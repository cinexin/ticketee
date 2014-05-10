class TagsController < ApplicationController

	def remove
		@ticket = Ticket.find(params[:ticket_id])

		if can?(:tag, @ticket.project) || current_user.admin?
			@tag = Tag.find(params[:id])
			# a super-cool way of removing an item from an array
			@ticket.tags -= [@tag]
			@ticket.save
			# remember this is an ajax request
			# this is the way to return a 200 OK status to the browser
			# "render :noting=>true"
			# but wait!!!! we want this script to be executed:
			# "app/views/tags/remove.js.erb"
			# so we simply do nothing
		end
	end
end
