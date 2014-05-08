class Admin::StatesController < Admin::BaseController

	before_action :set_state, only: [:show, :edit, :update, :destroy]

	def index
		@states = State.all
	end

	def show

	end

	def new
		@state = State.new
	end

	def create
		@state = State.new(state_params)

		if @state.save
			flash[:notice] = "State has been created."
			redirect_to admin_states_path
		else
			flash[:alert] = "State has not been created."
			render :action => "new"
		end
	end


	def edit

	end

	def update
		if @state.update(state_params)
			flash[:notice] = "State has been updated."
		else
			flash[:alert] = "State has not been udpated."
			redirect_to edit_admin_state_path(@state)
			return
		end

		redirect_to admin_state_path(@state)
	end

	private 

	def state_params
		params.require(:state).permit(:name, :color, :background)
	end

	def set_state
		@state = State.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The state you were looking for could not be found."
		redirect_to admin_states_path	
	end

end
