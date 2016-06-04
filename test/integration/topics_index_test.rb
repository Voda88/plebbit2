require 'test_helper'

class TopicsIndexTest < ActionDispatch::IntegrationTest
  	def setup
  		@admin=users(:michael)
  		@non_admin=users(:archer)
  	end

  test "index as admin including pagination and delete topics"  do
  	log_in_as(@admin)
  	get topics_path
  	assert_template 'topics/index'
  	assert_select 'div.pagination'
  	first_page_of_topics = Topic.paginate(page: 1)
  	first_page_of_topics.each do |topic|	
  		assert_select 'a[href=?]', user_path(topic.user), text: full_name(topic.user)
  		assert_select 'a[href=?]', topic_path(topic), text: topic.title
  		unless topic.user==@admin
  			assert_select 'a[href=?]', topic_path(topic), text: 'delete'
  		end
  	end
  	assert_difference 'Topic.count', -1 do
  		delete topic_path(@non_admin.topics.first)
  	end
  end

  test "index as non-admin" do
    log_in_as(@non_admin,remember_me:'0')
    get topics_path
    first_page_of_topics = Topic.paginate(page: 1)
  	first_page_of_topics.each do |topic|
  		assert_select 'a', text: full_name(topic.user), count:0
  		assert_select 'a[href=?]', topic_path(topic), text: topic.title
  		assert_select 'a', text: 'delete', count: 0
  	end 
  end



end
