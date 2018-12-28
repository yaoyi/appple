require 'blurrily/client'
namespace :appple do
  desc 'prepare data'
  task :prepare => :environment do
    client = Blurrily::Client.new
    File.foreach('words.txt') do |line|
      puts line
      line = line.strip
      word = Word.with_text(line).
        first_or_create
      client.put(line, word.id)
    end
  end
end
