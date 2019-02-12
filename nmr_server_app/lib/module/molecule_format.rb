require 'java'

require "#{Rails.root}/vendor/convert_to_smiles/Convert_To_Smiles.jar"


# java_import "xuan.convert_molecule_format.main"




module MoleculeFormat
	
	def self.included(receiver)

		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods

	end


	def self.convert_sdf_to_smiles(input)

		# input = "#{Rails.root}/public/tmp_sdf/tmp.sdf"
		smiles = `java -jar #{Rails.root}/vendor/convert_to_smiles/Convert_To_Smiles.jar #{input}`
		smiles = smiles.gsub("\n","")
		return smiles

	end


end







