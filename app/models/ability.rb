# This class will provide us the link between users and their permissions 

class Ability 
	include CanCan::Ability

	# this method will define how "can?" and "cannot?" methods will act
	def initialize(user)
		
		user.permissions.each do |p|
			can p.action.to_sym,
				p.thing_type.constantize do |thing|
					thing.nil? ||
					p.thing_id.nil? ||
					p.thing_id == thing.id
				end
		end
	end

end