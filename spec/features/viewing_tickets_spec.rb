require 'spec_helper'

feature "Viewing Tickets" do 

	before do 
		textmate_2 = FactoryGirl.create(:project, name: "TextMate 2")
		FactoryGirl.create(:ticket, project:textmate_2,
							title: "Make it shiny!",
							description: "Gradients! Starbusts! Oh my!")
		internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")
		FactoryGirl.create(:ticket, project:internet_explorer, title:"Standards compliance", description:"Isn't a joke")		
		
		visit "/"
	end
	
	scenario "Viewing tickets for a given project" do

		click_link "TextMate 2"
		expect(page).to have_content("Make it shiny!")
		expect(page).to_not have_content("Standards compliance")

		click_link "Make it shiny!"
		# this "within" method means: 
		# "find all elements with an ID of ticket that contain an <h2> with the specified content"
		within("#ticket h2") do
			expect(page).to have_content ("Make it shiny!")
		end
		expect(page).to have_content ("Gradients! Starbusts! Oh my!")
		expect(page).to_not have_content ("Standards compliance")
	end



end