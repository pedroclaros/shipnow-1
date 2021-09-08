require 'tempfile'

class FileHandler
  def initialize
  end

  def create_file(file_name, file_content)
    temp_file = Tempfile.new(file_name)

    temp_file << file_content

    temp_file.rewind
    temp_file
  end

  def show(created_file)
    created_file.read
  end

  def destroy_file(created_file)
    created_file.delete
  end

end

class DirectoryHandler
  def initialize
  end

  def create_folder(folder_name)
    return if Dir.exist?(folder_name)

    Dir.mkdir(folder_name)
  end

  def cd(folder_name)
    return "No existe el directorio" unless Dir.exist?(folder_name)

    return Dir.chdir(folder_name) unless folder_name == ".."

    Dir.chdir(File.dirname(Dir.pwd))
  end

  def whereami
    Dir.pwd
  end

  def destroy_folder(created_file)
    created_file.delete
  end

end


#Create a new instance File
new_file_handler = FileHandler.new

#Create a new instance Folder
directory_handler = DirectoryHandler.new

#Create new file and content
first_file = new_file_handler.create_file("file_1", "Contenido nuevo")

#Show file content
puts "Mi archivo contiene: #{new_file_handler.show(first_file)}"

#Create folder
folder = directory_handler.create_folder("folder_1")

#Positioning in folder created
directory_handler.cd("folder_1")

#Show the path
puts directory_handler.whereami

#Back in path
directory_handler.cd("..")
puts directory_handler.whereami

#Destroy file created and content 
new_file_handler.destroy_file(first_file)

