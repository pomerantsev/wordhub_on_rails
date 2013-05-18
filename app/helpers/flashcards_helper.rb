module FlashcardsHelper
	def first_line(string)
		eol = string.index("\r")
		return string if eol.nil?
		return truncate(string, length: eol + 3)
	end
end
