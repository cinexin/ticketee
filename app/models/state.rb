class State < ActiveRecord::Base

	def to_s
		name
	end

	def default!
		
		# the "find_by_default" method is a dynamic finder method from ActiveRecord
		current_default_state = State.find_by_default(true)
		self.default = true

		self.save!

		if current_default_state
			current_default_state.default = false
			current_default_state.save!
		end
	end
end
