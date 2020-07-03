require 'open-uri'
require 'colorize'





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


