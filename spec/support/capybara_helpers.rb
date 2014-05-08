# definition of some method helpers related with Capybara
# assert_no_link_for
# assert_link_for
module CapybaraHelpers
  
  def assert_no_link_for(text)
    expect(page).to_not(have_css("a", :text=>text), "Expected no to see the #{text.inspect} link, but did.")  
  end

  def assert_link_for(text)
    expect(page).to(have_css("a", :text=>text), "Expected to see the #{text.inspect} link, but didn't.")    
  end  

  def state_line_for(state)
  	state = State.find_by_name!(state)
  	"#state_#{state.id}"
  end

end

# as usual, we have to register these helpers in their context...
RSpec.configure do |config|
  config.include CapybaraHelpers, :type=>:feature
end
