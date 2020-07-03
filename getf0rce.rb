require 'open-uri'
require 'colorize'



=begin
	
	Bonjour je vais aujourd'hui développer un script permettant le bruteforce de get cela vous permettra par exemle de bruteforce un id par l'intermediaire d'une wordlist voilà c'est partie on va faire un truc complet faut savoir que qunad je fais des video speed coding je n'ai pas dev le script à l'avance c'est pourquoi je m'aide de stack overflow
	ou des doc de Ruby

go :)

FUCKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKkkkk
2 fois que je recommande ce fils de pute de vim
=end

class GetForce
	
	def help
		puts "Usage: #{__FILE__} <url> (https://example.com/account.php?id=:var:) <wordlist>"
		exit
	end

	def bruteforce(wordlist, url)
		wordlist.each do |line|
			replace_var = url.gsub(':var:', line)
			
			begin
				request = open("#{replace_var}")
				puts "Size: #{request.length}\nStatus: #{request.status}".green
			rescue OpenURI::HTTPError
				puts "Size: 0\nStatus: 404".red
					
			end
		end
	end

	def uriIsWork(uri)
	
		
		begin
			status_uri = open("http://#{URI(uri).host}")
			if status_uri.status == ["200", "OK"]
				return true
			else
				return false
			end
		rescue
			return false
		end
	end


	def main
		file_name = __FILE__
		url, wordlist = ARGV
		
		if ARGV.length != 2
			self.help
		end


		if !self.uriIsWork(url)
			puts "Error: Url not working".red
			exit
		end

		if !File.exist?(wordlist)
			puts "Error: #{wordlist} file not found".red
			exit
		end

		lines = File.readlines(wordlist)
		self.bruteforce(lines, url)

		
	end
	
end

getforce = GetForce.new

getforce.main


