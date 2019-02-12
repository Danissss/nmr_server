require 'java'

require "#{Rails.root}/vendor/nmr_pred/nmr_pred.jar"
require "#{Rails.root}/vendor/cdk/cdk-2.1.1.jar"

java_import "xuan.nmr_java.NmrPred"
java_import "xuan.nmr_java.Construct_Chem_Structure_sdf"


module RunNmrPred
	
	def self.included(receiver)

		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods

	end


	def self.run(input)

		value = `java -jar #{Rails.root}/vendor/nmr_pred/nmr_pred.jar #{input}`
		output = `python2 #{Rails.root}/vendor/callMatlab.py #{value}`
		x_array,y_array = RunNmrPred::prepare_data(output)
		return x_array,y_array

	end

	
	def self.run_example()

		file_path = "#{Rails.root}/public/HMDB00001.sdf"
		value = `java -jar #{Rails.root}/vendor/nmr_pred/nmr_pred.jar #{file_path}`
		
		return value
	end

	
	def self.draw_graph(shift)

		output = `python2 #{Rails.root}/vendor/callMatlab.py #{shift}`

		return output
		
	end

	# x_array,y_array return the array of value on x axis and y axis
	def self.draw_example_graph()

		shift = "3.07;3.16;3.68;3.96;7.0;7.67"
		output = `python2 #{Rails.root}/vendor/callMatlab.py #{shift}`
		x_array,y_array = RunNmrPred::prepare_data(output)
		return x_array,y_array
		
	end


	def self.prepare_data(input)

		output_list = input.split("matlab.double")

		x = output_list[1]
		y = output_list[2]

		x = x.gsub("[","")
		x = x.gsub("]","")
		x = x.gsub("(","")
		x = x.gsub(")","")
		x = x.gsub(" ","")

		y = y.gsub("]","")
		y = y.gsub("[","")
		y = y.gsub("(","")
		y = y.gsub(")","")
		y = y.gsub("\n","")
		y = y.gsub(" ","")

		x_string_array = x.split(",")
		y_string_array = y.split(",")

		x_array = []
		for x in 0 ... x_string_array.length
			x_array[x] = x_string_array[x].to_f
		end

		y_array = []
		for y in 0 ... y_string_array.length
			y_array[y] = y_string_array[y].to_f
		end

		return x_array,y_array

	end



	def self.loadsample()

		x_array = [1,2,3,4,5,6,7,8,9]
		y_array = [2,3,4,5,6,7,8,9,10]
		return x_array, y_array

	end

end







