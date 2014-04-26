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
	
	# authorized? method
	def authorized?(permission, thing, &block)
		# call the block if the user has permission on the object or 
		# if the user is an admin
		# remember the "CanCan" gem and see the "app/models/ability.rb" for details
		block.call if can?(permission.to_sym, thing) || current_user.try(:admin?)
	end
end
