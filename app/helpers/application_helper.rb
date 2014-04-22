module ApplicationHelper
	
	def title(*parts)
		unless parts.empty?
			content_for :title do
				(parts << "Ticketee").join(" - ")
			end
		end
	end
	
	# the block is the code between the "do" and "end"
	def admins_only(&block)
		# the "try" method tries a method on an object
		# if the method doesn't exist, it returns null instead of raising an exception
    	block.call if current_user.try(:admin?)  
	end
	
end
