module ApplicationHelper
	def flash_class(level)
		case level
		when 'success' then "alert alert-success fade in"
		when 'error' then "alert alert-danger fade in"
		end
	end
end
