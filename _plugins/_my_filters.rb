require 'liquid'
require 'uri'

# Capitalize all words of the input
module LexFilters
	def entitle(words)
		return words.gsub('-', ' ').split(' ').map(&:capitalize).join(' ')
	end

	def create_id(words)
		return URI.decode(words).gsub(/\W+/, ' ').strip().gsub(" ", "-")
	end
end

Liquid::Template.register_filter(LexFilters)
