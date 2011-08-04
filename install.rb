require 'rubygems'
require 'progressbar'
require 'zip'

require 'rbconfig'
require 'net/http'
require 'tempfile'

puts 'downloading and installing required SDL libraries for rubygame'
puts '(this install script may need administrator priveleges to run)'

def quit(msg)
  puts msg
  exit 1
end

# check to see if we're running windows
quit 'installer is for windows only, sorry.' unless Config::CONFIG['host_os'] =~ /mswin|mingw/

# ensure windows directory
win_dir = ENV['win_dir'] || 'c:/windows'
quit 'strange, no windows directory found.' unless Dir.exists?(win_dir)

# 64- or 32-bit installation
sys64_dir = File.join(win_dir, 'syswow64')
sys32_dir = File.join(win_dir, 'system32')
install_dir = Dir.exists?(sys64_dir) ? sys64_dir : sys32_dir

# final sanity check
quit "could not locate installation directory (#{install_dir})" unless Dir.exists?(install_dir)

# installation steps
def download(name, url)
  puts "downloading #{url}"
  uri = URI.parse(url)
  download = Net::HTTP::Get.new(uri.path)
  local_file = Tempfile.new(name)
  local_file.binmode
  
  Net::HTTP.start(uri.host, uri.port) do |client|
    client.request(download) do |response|
      progress_bar = ProgressBar.new(name, response.content_length)      
      response.read_body { |segment|
        progress_bar.inc(segment.length)
        local_file.write(segment)
      }      
      progress_bar.finish
    end
  end
  
  local_file.close
  local_file.path
end

def extract(local_file)
  puts "extracting from downloaded file"
  extraction_dir = Dir.mktmpdir
  
  Zip::ZipFile.open(local_file) do |zip_file|
    zip_file.each do |extracted_file|
      extract_path = File.join(extraction_dir, extracted_file.name)
      FileUtils.mkdir_p(File.dirname(extract_path))
      zip_file.extract(extracted_file, extract_path)      
    end
  end
      
  extraction_dir
end

def copy_dlls(src_dir, dst_dir)
  Dir["#{src_dir}/**/*.dll"].each do |dll|
    name = File.basename(dll)
    destination = File.join(dst_dir, name)
    unless File.exists?(destination)
      puts "copying dll to #{destination}"
      FileUtils.cp(dll, destination)
    else
      puts "skipping #{destination} (dll is already present)"
    end       
  end
  
  # cleanup extraction directory
  FileUtils.rm_r(src_dir, :force => true)
end

def install(name, url, install_dir)
  begin
    puts "=> installing #{name}"
    local_file = download(name, url)
    extracted_dir = extract(local_file)
    copy_dlls(extracted_dir, install_dir)
    puts "<= done"
  rescue Exception => e
    puts e.message
    puts e.backtrace
    quit "an error occurred while attempting to install #{name}"
  end 
end

# required SDL library downloads
sdl_downloads = {
  'SDL' =>       'http://www.libsdl.org/release/SDL-1.2.14-win32.zip',
  'SDL Image' => 'http://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.10-win32.zip',
  'SDL Mixer' => 'http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.11-win32.zip',
  'SDL TTF' =>   'http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-2.0.10-win32.zip',
  'SDL GFX' =>   'http://download.rubygame.org/files/extras/SDL_gfx-2.0.18-win32.zip'  
}

# kick off the installation
sdl_downloads.each { |name, file| install(name, file, install_dir) }


