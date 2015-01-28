class TransformationController < ApplicationController
	include ActionView::Helpers::TextHelper

	def tf_tag_descriptions

	end

	def pre_made_text

	end

	def clean_up_tf
		tfs = Transformation.all

		tfs.each do |tf|
			if tf.character.nil?
				Transformation.delete(tf)
			end
		end
		flash[:error] = 'TFs Cleaned Up'
		redirect_to tf_admin_path
	end

	def admin
    	if current_user.is_admin
      		@tfs = Transformation.all
      		#render :template => "/game/admin"
    	else
      		redirect_to game_rules_path
    	end
 	end
	
	def delete_tf
		if params[:id].nil?
			flash[:error] = "The Transformation Could Not Be Found."
			redirect_to tf_admin_path
		else
			tf = Transformation.find_by_id(params[:id])
			Transformation.delete(tf)
			flash[:error] = "The Transformation has been successfully deleted."
			redirect_to tf_admin_path
		end
	end

	def auto_write

		create_hash = {}
		transformation = params["transformation"]
		tf = Array.new(10) {|e| e = ""}
		char = Array.new(4) {|e| e = ""}
		if(transformation["is_M2F"] == "1")
			results = Transformation::auto_write_tf_text("m2f", params["character_name"])
			i = 0
			tf.each do |tf_text|
				tf_text = tf_text + results[i] + "<br>"
				tf[i] = tf_text
				i = i + 1
			end
			#binding.pry
			results = Transformation::auto_write_char_text("m2f", params["character_name"])
			i = 0
			char.each do |char_text|
				char_text = char_text + results[i] + "<br>"
				char[i] = char_text
			   i = i + 1
			end
			create_hash[:is_M2F] = true
		else
			create_hash[:is_M2F] = true
		end
		if(transformation["is_F2M"] == "1")
			results = Transformation::auto_write_tf_text("f2m", params["character_name"])
			i = 0
			tf.each do |tf_text|
				tf_text = tf_text + results[i] + "<br>"
				tf[i] = tf_text
				i = i + 1
			end
			results = Transformation::auto_write_char_text("f2m", params["character_name"])
			i = 0
			char.each do |char_text|
				char_text = char_text + results[i] + "<br>"
				char[i] = char_text
			   i = i + 1
			end
			create_hash[:is_F2M] = true
		else
			create_hash[:is_F2M] = false
		end 
		if(transformation["is_age_reg"] == "1")
			results = Transformation::auto_write_tf_text("age_reg", params["character_name"])
			i = 0
			tf.each do |tf_text|
				tf_text = tf_text + results[i] + "<br>"
				tf[i] = tf_text
				i = i + 1
			end
			results = Transformation::auto_write_char_text("age_reg", params["character_name"])
			i = 0
			char.each do |char_text|
				char_text = char_text + results[i] + "<br>"
				char[i] = char_text
			   i = i + 1
			end
			create_hash[:is_age_reg] = true
		else
			create_hash[:is_age_reg] = false
		end 
		if(transformation["is_Furry"] == "1")
			results = Transformation::auto_write_tf_text("furry", params["character_name"])
			i = 0
			tf.each do |tf_text|
				tf_text = tf_text + results[i] + "<br>"
				tf[i] = tf_text
				i = i + 1
			end
			results = Transformation::auto_write_char_text("furry", params["character_name"])
			i = 0
			char.each do |char_text|
				char_text = char_text + results[i] + "<br>"
				char[i] = char_text
			   i = i + 1
			end
			create_hash[:is_furry] = true
		else
			create_hash[:is_furry] = false
		end 
		if(transformation["is_Inanimate"] == "1")
			results = Transformation::auto_write_tf_text("inanimate", params["character_name"])
			i = 0
			tf.each do |tf_text|
				tf_text = tf_text + results[i] + "<br>"
				tf[i] = tf_text
				i = i + 1
			end
			results = Transformation::auto_write_char_text("inanimate", params["character_name"])
			i = 0
			char.each do |char_text|
				char_text = char_text + results[i] + "<br>"
				char[i] = char_text
			   i = i + 1
			end
			create_hash[:is_inanimate] = true
		else
			create_hash[:is_inanimate] = false
		end 

		
		create_hash[:character_name] = params["character_name"]
		create_hash[:stage1_tf_description] = tf[0]
		create_hash[:stage1_character_description] = char[0]
		create_hash[:stage1_tf_picture] = "No Picture"
		create_hash[:stage2_tf_description] = tf[1]
		create_hash[:stage2_character_description] = char[0]
		create_hash[:stage2_tf_picture] = "No Picture"
		create_hash[:stage3_tf_description] = tf[2]
		create_hash[:stage3_character_description] = char[1]
		create_hash[:stage3_tf_picture] = "No Picture"
		create_hash[:stage4_tf_description] = tf[3]
		create_hash[:stage4_character_description] = char[1]
		create_hash[:stage4_tf_picture] = "No Picture"
		create_hash[:stage5_tf_description] = tf[4]
		create_hash[:stage5_character_description] = char[1]
		create_hash[:stage5_tf_picture] = "No Picture"
		create_hash[:stage6_tf_description] = tf[5]
		create_hash[:stage6_character_description] = char[2]
		create_hash[:stage6_tf_picture] = "No Picture"
		create_hash[:stage7_tf_description] = tf[6]
		create_hash[:stage7_character_description] = char[2]
		create_hash[:stage7_tf_picture] = "No Picture"
		create_hash[:stage8_tf_description] = tf[7]
		create_hash[:stage8_character_description] = char[2]
		create_hash[:stage8_tf_picture] = "No Picture"
		create_hash[:stage9_tf_description] = tf[8]
		create_hash[:stage9_character_description] = char[3]
		create_hash[:stage9_tf_picture] = "No Picture"
		create_hash[:stage10_tf_description] = tf[9]
		create_hash[:stage10_character_description] = char[3]
		create_hash[:stage10_tf_picture] = "No Picture"
		create_hash[:is_adult] = false
		create_hash[:is_race_change] = false
		create_hash[:is_age_pro] = false
		create_hash[:is_animal] = false
		create_hash[:is_futa] = false
		create_hash[:is_mind] = false
		create_hash[:is_bdsm] = false
		create_hash[:is_pregnant] = false
		create_hash[:is_growth] = false
		create_hash[:is_shrink] = false
		create_hash[:is_weight_gain] = false
		create_hash[:is_fantasy] = false
		create_hash[:is_bimbo] = false
		create_hash[:is_bizarre] = false
		create_hash[:is_robot] = false
		create_hash[:is_monster_girl] = false
		create_hash[:upvotes] = 0

		new_tf = Transformation.create!(create_hash)
		character = Character.find_by_name(params["character_name"])
		character.transformation = new_tf
		character.save
		new_tf.save

		#binding.pry

		redirect_to transformation_edit_path(:character_name => params["character_name"])

	end

	def select_num_stages
		@character_name = params["character_name"]
	end

	def stage_setup
		action = params["Action"]
		if (action.nil?)
			flash[:error] = "You Must Select a Number of Stages Before Continuing"
			redirect_to select_num_stages_path(:character_name => params["character_name"])
		else
			if action == "3"
				redirect_to new_tf3_path(:character_name => params["character_name"])
			elsif action == "5"
				redirect_to new_tf5_path(:character_name => params["character_name"])
			elsif action == "10"
				redirect_to tf_path(:character_name => params["character_name"])
			else
				flash[:error] = "An Error has Occured. Please Select a Number and Try Again."
			  	redirect_to select_num_stages_path(:character_name => params["character_name"])
			end
				
		end
	end

	def show
		#redirect_to transformation_edit_path(:character_name => params["character_name"])
		#if current_user.is_admin
      		@tf = Transformation.find_by_character_name(params[:name])
      		if @tf.nil?
      			flash[:notice] = "This Character Does Not Have an Associated Transformation"
      			redirect_to character_admin_path
    		else
      			@tag_list = Transformation::get_tag_list(@tf)
    		end
    	#else
      		#redirect_to game_rules_path
    	#end
		
	end

	def edit
		@character_name = params["character_name"]
		@transformation = Transformation.find_by_character_name(@character_name)
		#binding.pry
	end

	def new_tf
		#binding.pry
		#render "new_tf"
		@character_name = params["character_name"]
	end

	def new_tf3
		#binding.pry
		#render "new_tf"
		@character_name = params["character_name"]
	end

	def new_tf5
		#binding.pry
		#render "new_tf"
		@character_name = params["character_name"]
	end

	def add_to_character
		#binding.pry
		#Get Character Name
		character_name = params["character_name"]

		create_hash = {}
		#Get Text/Picture URLS
		create_hash["stage1_character_description"] = word_wrap(params["transformation"]["stage1_character_description"])
		create_hash["stage1_tf_description"] = word_wrap(params["transformation"]["stage1_tf_description"])
		create_hash["stage1_tf_picture"] = params["transformation"]["stage1_tf_picture"]

		create_hash["stage2_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage2_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage2_tf_picture"] = params["transformation"]["stage2_tf_picture"]

		create_hash["stage3_character_description"] = word_wrap(params["transformation"]["stage3_character_description"])
		create_hash["stage3_tf_description"] = word_wrap(params["transformation"]["stage3_tf_description"])
		create_hash["stage3_tf_picture"] = word_wrap(params["transformation"]["stage3_tf_picture"])

		create_hash["stage4_character_description"] = word_wrap(params["transformation"]["stage4_character_description"])
		create_hash["stage4_tf_description"] = word_wrap(params["transformation"]["stage4_tf_description"])
		create_hash["stage4_tf_picture"] = params["transformation"]["stage4_tf_picture"]

		create_hash["stage5_character_description"] = word_wrap(params["transformation"]["stage5_character_description"])
		create_hash["stage5_tf_description"] = word_wrap(params["transformation"]["stage5_tf_description"])
		create_hash["stage5_tf_picture"] = word_wrap(params["transformation"]["stage5_tf_picture"])

		create_hash["stage6_character_description"] = word_wrap(params["transformation"]["stage6_character_description"])
		create_hash["stage6_tf_description"] = word_wrap(params["transformation"]["stage6_tf_description"])
		create_hash["stage6_tf_picture"] = params["transformation"]["stage6_tf_picture"]

		create_hash["stage7_character_description"] = word_wrap(params["transformation"]["stage7_character_description"])
		create_hash["stage7_tf_description"] = word_wrap(params["transformation"]["stage7_tf_description"])
		create_hash["stage7_tf_picture"] = params["transformation"]["stage7_tf_picture"]

		create_hash["stage8_character_description"] = word_wrap(params["transformation"]["stage8_character_description"])
		create_hash["stage8_tf_description"] = word_wrap(params["transformation"]["stage8_tf_description"])
		create_hash["stage8_tf_picture"] = params["transformation"]["stage8_tf_picture"]

		create_hash["stage9_character_description"] = word_wrap(params["transformation"]["stage9_character_description"])
		create_hash["stage9_tf_description"] = word_wrap(params["transformation"]["stage9_tf_description"])
		create_hash["stage9_tf_picture"] = params["transformation"]["stage9_tf_picture"]

		create_hash["stage10_character_description"] = word_wrap(params["transformation"]["stage10_character_description"])
		create_hash["stage10_tf_description"] = word_wrap(params["transformation"]["stage10_tf_description"])
		create_hash["stage10_tf_picture"] = params["transformation"]["stage10_tf_picture"]

		valid = true
		create_hash.each do |key, value|
			if value.blank?
				create_hash[key] = "No Description"
			end
		end

		if(valid)
			#Obtain TF Tags
			create_hash["is_adult"] = params["transformation"]["is_adult"]
			create_hash["is_M2F"] = params["transformation"]["is_M2F"]
			create_hash["is_F2M"] = params["transformation"]["is_F2M"]		
			create_hash["is_race_change"] = params["transformation"]["is_race_change"]
			create_hash["is_age_reg"] = params["transformation"]["is_age_reg"]
			create_hash["is_age_pro"] = params["transformation"]["is_age_pro"]
			create_hash["is_furry"] = params["transformation"]["is_furry"]
			create_hash["is_animal"] = params["transformation"]["is_animal"]
			create_hash["is_futa"] = params["transformation"]["is_futa"]
			create_hash["is_mind"] = params["transformation"]["is_mind"]
			create_hash["is_bdsm"] = params["transformation"]["is_bdsm"]
			create_hash["is_pregnant"] = params["transformation"]["is_pregnant"]
			create_hash["is_inanimate"] = params["transformation"]["is_inanimate"]
			create_hash["is_growth"] = params["transformation"]["is_growth"]
			create_hash["is_shrink"] = params["transformation"]["is_shrink"]
			create_hash["is_weight_gain"] = params["transformation"]["is_weight_gain"]
			create_hash["is_fantasy"] = params["transformation"]["is_fantasy"]
			create_hash["is_bimbo"] = params["transformation"]["is_bimbo"]	
			create_hash["is_robot"] = params["transformation"]["is_robot"]	
			create_hash["is_monster_girl"] = params["transformation"]["is_monster_girl"]
			create_hash["is_bizarre"] = params["transformation"]["is_bizarre"]
			create_hash["is_completed"] = params["transformation"]["is_completed"]
			create_hash["is_full_picture"] = params["transformation"]["is_full_picture"]

			create_hash["character_name"] = character_name
			create_hash["upvotes"] = 0

			current_character = Character.find_by_name(character_name)
			if(Character.nil?)
				flash[:error] = "ERROR: The Character Your Adding Transformations to Could Not Be Found. "
				redirect_to tf_path(:character_name => character_name)
			else
				tf = Transformation.create!(create_hash)
				current_character.transformation = tf
			end

		else
			flash[:error] = "ERROR: One Or More Fields were Left Blank. Please Enter in Text for EVERY Field."
			redirect_to tf_path(:character_name => character_name)
		end


		#binding.pry
		flash[:notice] = "#{character_name} has been created successfully!"
		redirect_to game_rules_path
	end

	def add_to_character3
		#binding.pry
		#Get Character Name
		character_name = params["character_name"]

		create_hash = {}
		#Get Text/Picture URLS
		create_hash["stage1_character_description"] = word_wrap(params["transformation"]["stage1_character_description"])
		create_hash["stage1_tf_description"] = word_wrap(params["transformation"]["stage1_tf_description"])
		create_hash["stage1_tf_picture"] = params["transformation"]["stage1_tf_picture"]

		create_hash["stage2_character_description"] = word_wrap(params["transformation"]["stage1_character_description"])
		create_hash["stage2_tf_description"] = word_wrap(params["transformation"]["stage1_tf_description"])
		create_hash["stage2_tf_picture"] = params["transformation"]["stage1_tf_picture"]

		create_hash["stage3_character_description"] = word_wrap(params["transformation"]["stage1_character_description"])
		create_hash["stage3_tf_description"] = word_wrap(params["transformation"]["stage1_tf_description"])
		create_hash["stage3_tf_picture"] = word_wrap(params["transformation"]["stage1_tf_picture"])

		create_hash["stage4_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage4_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage4_tf_picture"] = params["transformation"]["stage2_tf_picture"]

		create_hash["stage5_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage5_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage5_tf_picture"] = word_wrap(params["transformation"]["stage2_tf_picture"])

		create_hash["stage6_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage6_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage6_tf_picture"] = params["transformation"]["stage2_tf_picture"]

		create_hash["stage7_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage7_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage7_tf_picture"] = params["transformation"]["stage2_tf_picture"]

		create_hash["stage8_character_description"] = word_wrap(params["transformation"]["stage3_character_description"])
		create_hash["stage8_tf_description"] = word_wrap(params["transformation"]["stage3_tf_description"])
		create_hash["stage8_tf_picture"] = params["transformation"]["stage3_tf_picture"]

		create_hash["stage9_character_description"] = word_wrap(params["transformation"]["stage3_character_description"])
		create_hash["stage9_tf_description"] = word_wrap(params["transformation"]["stage3_tf_description"])
		create_hash["stage9_tf_picture"] = params["transformation"]["stage3_tf_picture"]

		create_hash["stage10_character_description"] = word_wrap(params["transformation"]["stage3_character_description"])
		create_hash["stage10_tf_description"] = word_wrap(params["transformation"]["stage3_tf_description"])
		create_hash["stage10_tf_picture"] = params["transformation"]["stage3_tf_picture"]

		valid = true
		create_hash.each do |key, value|
			if value.blank?
				create_hash[key] = "No Description"
			end
		end

		if(valid)
			#Obtain TF Tags
			create_hash["is_adult"] = params["transformation"]["is_adult"]
			create_hash["is_M2F"] = params["transformation"]["is_M2F"]
			create_hash["is_F2M"] = params["transformation"]["is_F2M"]		
			create_hash["is_race_change"] = params["transformation"]["is_race_change"]
			create_hash["is_age_reg"] = params["transformation"]["is_age_reg"]
			create_hash["is_age_pro"] = params["transformation"]["is_age_pro"]
			create_hash["is_furry"] = params["transformation"]["is_furry"]
			create_hash["is_animal"] = params["transformation"]["is_animal"]
			create_hash["is_futa"] = params["transformation"]["is_futa"]
			create_hash["is_mind"] = params["transformation"]["is_mind"]
			create_hash["is_bdsm"] = params["transformation"]["is_bdsm"]
			create_hash["is_pregnant"] = params["transformation"]["is_pregnant"]
			create_hash["is_inanimate"] = params["transformation"]["is_inanimate"]
			create_hash["is_growth"] = params["transformation"]["is_growth"]
			create_hash["is_shrink"] = params["transformation"]["is_shrink"]
			create_hash["is_weight_gain"] = params["transformation"]["is_weight_gain"]
			create_hash["is_fantasy"] = params["transformation"]["is_fantasy"]
			create_hash["is_bimbo"] = params["transformation"]["is_bimbo"]	
			create_hash["is_robot"] = params["transformation"]["is_robot"]	
			create_hash["is_monster_girl"] = params["transformation"]["is_monster_girl"]
			create_hash["is_bizarre"] = params["transformation"]["is_bizarre"]
			create_hash["is_completed"] = params["transformation"]["is_completed"]
			create_hash["is_full_picture"] = params["transformation"]["is_full_picture"]

			create_hash["character_name"] = character_name
			create_hash["upvotes"] = 0

			current_character = Character.find_by_name(character_name)
			if(Character.nil?)
				flash[:error] = "ERROR: The Character Your Adding Transformations to Could Not Be Found. "
				redirect_to tf_path(:character_name => character_name)
			else
				tf = Transformation.create!(create_hash)
				current_character.transformation = tf
			end

		else
			flash[:error] = "ERROR: One Or More Fields were Left Blank. Please Enter in Text for EVERY Field."
			redirect_to new_tf3_path(:character_name => character_name)
		end


		#binding.pry
		flash[:notice] = "#{character_name} has been created successfully!"
		redirect_to game_rules_path
	end

	def add_to_character5
		#binding.pry
		#Get Character Name
		character_name = params["character_name"]

		create_hash = {}
		#Get Text/Picture URLS
		create_hash["stage1_character_description"] = word_wrap(params["transformation"]["stage1_character_description"])
		create_hash["stage1_tf_description"] = word_wrap(params["transformation"]["stage1_tf_description"])
		create_hash["stage1_tf_picture"] = params["transformation"]["stage1_tf_picture"]

		create_hash["stage2_character_description"] = word_wrap(params["transformation"]["stage1_character_description"])
		create_hash["stage2_tf_description"] = word_wrap(params["transformation"]["stage1_tf_description"])
		create_hash["stage2_tf_picture"] = params["transformation"]["stage1_tf_picture"]

		create_hash["stage3_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage3_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage3_tf_picture"] = word_wrap(params["transformation"]["stage2_tf_picture"])

		create_hash["stage4_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage4_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage4_tf_picture"] = params["transformation"]["stage2_tf_picture"]

		create_hash["stage5_character_description"] = word_wrap(params["transformation"]["stage3_character_description"])
		create_hash["stage5_tf_description"] = word_wrap(params["transformation"]["stage3_tf_description"])
		create_hash["stage5_tf_picture"] = word_wrap(params["transformation"]["stage3_tf_picture"])

		create_hash["stage6_character_description"] = word_wrap(params["transformation"]["stage3_character_description"])
		create_hash["stage6_tf_description"] = word_wrap(params["transformation"]["stage3_tf_description"])
		create_hash["stage6_tf_picture"] = params["transformation"]["stage3_tf_picture"]

		create_hash["stage7_character_description"] = word_wrap(params["transformation"]["stage4_character_description"])
		create_hash["stage7_tf_description"] = word_wrap(params["transformation"]["stage4_tf_description"])
		create_hash["stage7_tf_picture"] = params["transformation"]["stage4_tf_picture"]

		create_hash["stage8_character_description"] = word_wrap(params["transformation"]["stage4_character_description"])
		create_hash["stage8_tf_description"] = word_wrap(params["transformation"]["stage4_tf_description"])
		create_hash["stage8_tf_picture"] = params["transformation"]["stage4_tf_picture"]

		create_hash["stage9_character_description"] = word_wrap(params["transformation"]["stage5_character_description"])
		create_hash["stage9_tf_description"] = word_wrap(params["transformation"]["stage5_tf_description"])
		create_hash["stage9_tf_picture"] = params["transformation"]["stage5_tf_picture"]

		create_hash["stage10_character_description"] = word_wrap(params["transformation"]["stage5_character_description"])
		create_hash["stage10_tf_description"] = word_wrap(params["transformation"]["stage5_tf_description"])
		create_hash["stage10_tf_picture"] = params["transformation"]["stage5_tf_picture"]

		valid = true
		create_hash.each do |key, value|
			if value.blank?
				create_hash[key] = "No Description"
			end
		end

		if(valid)
			#Obtain TF Tags
			create_hash["is_adult"] = params["transformation"]["is_adult"]
			create_hash["is_M2F"] = params["transformation"]["is_M2F"]
			create_hash["is_F2M"] = params["transformation"]["is_F2M"]		
			create_hash["is_race_change"] = params["transformation"]["is_race_change"]
			create_hash["is_age_reg"] = params["transformation"]["is_age_reg"]
			create_hash["is_age_pro"] = params["transformation"]["is_age_pro"]
			create_hash["is_furry"] = params["transformation"]["is_furry"]
			create_hash["is_animal"] = params["transformation"]["is_animal"]
			create_hash["is_futa"] = params["transformation"]["is_futa"]
			create_hash["is_mind"] = params["transformation"]["is_mind"]
			create_hash["is_bdsm"] = params["transformation"]["is_bdsm"]
			create_hash["is_pregnant"] = params["transformation"]["is_pregnant"]
			create_hash["is_inanimate"] = params["transformation"]["is_inanimate"]
			create_hash["is_growth"] = params["transformation"]["is_growth"]
			create_hash["is_shrink"] = params["transformation"]["is_shrink"]
			create_hash["is_weight_gain"] = params["transformation"]["is_weight_gain"]
			create_hash["is_fantasy"] = params["transformation"]["is_fantasy"]
			create_hash["is_bimbo"] = params["transformation"]["is_bimbo"]	
			create_hash["is_robot"] = params["transformation"]["is_robot"]	
			create_hash["is_monster_girl"] = params["transformation"]["is_monster_girl"]
			create_hash["is_bizarre"] = params["transformation"]["is_bizarre"]
			create_hash["is_completed"] = params["transformation"]["is_completed"]
			create_hash["is_full_picture"] = params["transformation"]["is_full_picture"]

			create_hash["character_name"] = character_name
			create_hash["upvotes"] = 0

			current_character = Character.find_by_name(character_name)
			if(Character.nil?)
				flash[:error] = "ERROR: The Character Your Adding Transformations to Could Not Be Found. "
				redirect_to tf_path(:character_name => character_name)
			else
				tf = Transformation.create!(create_hash)
				current_character.transformation = tf
			end

		else
			flash[:error] = "ERROR: One Or More Fields were Left Blank. Please Enter in Text for EVERY Field."
			redirect_to new_tf5_path(:character_name => character_name)
		end


		#binding.pry
		flash[:notice] = "#{character_name} has been created successfully!"
		redirect_to game_rules_path
	end

	def update
				#binding.pry
		#Get Character Name
		character_name = params["character_name"]

		create_hash = {}
		#Get Text/Picture URLS
		create_hash["stage1_character_description"] = word_wrap(params["transformation"]["stage1_character_description"])
		create_hash["stage1_tf_description"] = word_wrap(params["transformation"]["stage1_tf_description"])
		create_hash["stage1_tf_picture"] = params["transformation"]["stage1_tf_picture"]

		create_hash["stage2_character_description"] = word_wrap(params["transformation"]["stage2_character_description"])
		create_hash["stage2_tf_description"] = word_wrap(params["transformation"]["stage2_tf_description"])
		create_hash["stage2_tf_picture"] = params["transformation"]["stage2_tf_picture"]

		create_hash["stage3_character_description"] = word_wrap(params["transformation"]["stage3_character_description"])
		create_hash["stage3_tf_description"] = word_wrap(params["transformation"]["stage3_tf_description"])
		create_hash["stage3_tf_picture"] = word_wrap(params["transformation"]["stage3_tf_picture"])

		create_hash["stage4_character_description"] = word_wrap(params["transformation"]["stage4_character_description"])
		create_hash["stage4_tf_description"] = word_wrap(params["transformation"]["stage4_tf_description"])
		create_hash["stage4_tf_picture"] = params["transformation"]["stage4_tf_picture"]

		create_hash["stage5_character_description"] = word_wrap(params["transformation"]["stage5_character_description"])
		create_hash["stage5_tf_description"] = word_wrap(params["transformation"]["stage5_tf_description"])
		create_hash["stage5_tf_picture"] = word_wrap(params["transformation"]["stage5_tf_picture"])

		create_hash["stage6_character_description"] = word_wrap(params["transformation"]["stage6_character_description"])
		create_hash["stage6_tf_description"] = word_wrap(params["transformation"]["stage6_tf_description"])
		create_hash["stage6_tf_picture"] = params["transformation"]["stage6_tf_picture"]

		create_hash["stage7_character_description"] = word_wrap(params["transformation"]["stage7_character_description"])
		create_hash["stage7_tf_description"] = word_wrap(params["transformation"]["stage7_tf_description"])
		create_hash["stage7_tf_picture"] = params["transformation"]["stage7_tf_picture"]

		create_hash["stage8_character_description"] = word_wrap(params["transformation"]["stage8_character_description"])
		create_hash["stage8_tf_description"] = word_wrap(params["transformation"]["stage8_tf_description"])
		create_hash["stage8_tf_picture"] = params["transformation"]["stage8_tf_picture"]

		create_hash["stage9_character_description"] = word_wrap(params["transformation"]["stage9_character_description"])
		create_hash["stage9_tf_description"] = word_wrap(params["transformation"]["stage9_tf_description"])
		create_hash["stage9_tf_picture"] = params["transformation"]["stage9_tf_picture"]

		create_hash["stage10_character_description"] = word_wrap(params["transformation"]["stage10_character_description"])
		create_hash["stage10_tf_description"] = word_wrap(params["transformation"]["stage10_tf_description"])
		create_hash["stage10_tf_picture"] = params["transformation"]["stage10_tf_picture"]
		valid = true
		create_hash.each do |key, value|
			if value.blank?
				create_hash[key] = "No Description"
			end
		end

		if(valid)
			#Obtain TF Tags
			create_hash["is_adult"] = params["transformation"]["is_adult"]
			create_hash["is_M2F"] = params["transformation"]["is_M2F"]
			create_hash["is_F2M"] = params["transformation"]["is_F2M"]		
			create_hash["is_race_change"] = params["transformation"]["is_race_change"]
			create_hash["is_age_reg"] = params["transformation"]["is_age_reg"]
			create_hash["is_age_pro"] = params["transformation"]["is_age_pro"]
			create_hash["is_furry"] = params["transformation"]["is_furry"]
			create_hash["is_animal"] = params["transformation"]["is_animal"]
			create_hash["is_futa"] = params["transformation"]["is_futa"]
			create_hash["is_mind"] = params["transformation"]["is_mind"]
			create_hash["is_bdsm"] = params["transformation"]["is_bdsm"]
			create_hash["is_pregnant"] = params["transformation"]["is_pregnant"]
			create_hash["is_inanimate"] = params["transformation"]["is_inanimate"]
			create_hash["is_growth"] = params["transformation"]["is_growth"]
			create_hash["is_shrink"] = params["transformation"]["is_shrink"]
			create_hash["is_weight_gain"] = params["transformation"]["is_weight_gain"]
			create_hash["is_fantasy"] = params["transformation"]["is_fantasy"]
			create_hash["is_bimbo"] = params["transformation"]["is_bimbo"]	
			create_hash["is_robot"] = params["transformation"]["is_robot"]	
			create_hash["is_monster_girl"] = params["transformation"]["is_monster_girl"]
			create_hash["is_bizarre"] = params["transformation"]["is_bizarre"]
			create_hash["is_completed"] = params["transformation"]["is_completed"]
			create_hash["is_full_picture"] = params["transformation"]["is_full_picture"]

			create_hash["character_name"] = character_name
			create_hash["upvotes"] = 0

			current_character = Character.find_by_name(character_name)
			if(Character.nil?)
				flash[:error] = "ERROR: The Character Your Adding Transformations to Could Not Be Found. "
				redirect_to transformation_edit_path(:character_name => character_name)
			else
				tf = Transformation.find_by_character_name(character_name)
				if tf.nil?
					tf = Transformation.create!(create_hash)
				else
					tf.update_attributes(create_hash)
				end
				current_character.transformation = tf
			end

		else
			flash[:error] = "ERROR: One Or More Fields were Left Blank. Please Enter in Text for EVERY Field."
			redirect_to transformation_edit_path(:character_name => character_name)
		end


		#binding.pry
		flash[:notice] = "#{character_name}'s transformation has been updated successfully!"
		redirect_to game_rules_path
	end

	def set_completed_and_fully_illustrated_to_false
		tfs = Transformation.all
		tfs.each do |tf|
			tf.is_completed = false
			tf.is_full_picture = false
			tf.save
		end
		redirect_to tf_admin_path
	end

end
