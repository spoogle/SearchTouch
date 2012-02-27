require 'rubygems'
require 'pp'

filename = "cia_world_factbook_2010.txt"
extractedir = "world_factbook"
FileUtils::mkdir(extractedir) if !File::exist? "world_factbook"


title = nil; text = ""
File.open(filename,"r").each_line do |l|
  if (l =~ /^@/) then
    l.strip!
    if (title) then
      # write old file
      fd = File.open("#{extractedir}/#{title.gsub(/ /,'_')}.txt","w");
      fd.write(title+"\n")
      fd.write(text+"\n");
      fd.close
    end
    title = l.sub(/@/,"");
    text = ""
  else
    text = text + l
  end
end



