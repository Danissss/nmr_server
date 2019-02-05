class QueryController < ApplicationController


	def new
		
	end

	def result

		# pass the parameter from new.html.erb to result.html.erb by get("/result")
		# @my_var = 'toto'
		# in view
		# <%= @my_var %>

		if !params[:test_sample].nil?
			# x_array, y_array = RunNmrPred::draw_example_graph()
			x_array, y_array = RunNmrPred::draw_example_graph()
			@x_axis = x_array
			@y_axis = y_array
		end

		# render plain: params[:test_sample].inspect
		# render plain: params.inspect
	end
end
