class CharactersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def new
    
    if !params[:character].nil?
      @name = params[:character][:name]
      @description = params[:character][:description]
      @description = word_wrap(@description)
      @max_hp = params[:character][:max_hp].to_i
      @max_mp = params[:character][:max_mp].to_i
      @base_attack = params[:character][:base_attack].to_i
      @base_power = params[:character][:base_power].to_i
      @base_defense = params[:character][:base_defense].to_i
      @base_armor = params[:character][:base_armor].to_i

      @action_1_name = params[:character][:action_1_name]
      @action_1_flavor = params[:character][:action_1_flavor]
      @action_1_rules = params[:character][:action_1_rules]

      @action_2_name = params[:character][:action_2_name]
      @action_2_flavor = params[:character][:action_2_flavor]
      @action_2_rules = params[:character][:action_2_rules]

      @action_3_name = params[:character][:action_3_name]
      @action_3_flavor = params[:character][:action_3_flavor]
      @action_3_rules = params[:character][:action_3_rules]

      @action_4_name = params[:character][:action_4_name]
      @action_4_flavor = params[:character][:action_4_flavor]
      @action_4_rules = params[:character][:action_4_rules]

      @summon_name = params[:character][:summon_name]
      @summon_picture = params[:character][:summon_picture]
      @summon_attack = params[:character][:summon_attack] 

      @action_1_effect = (params[:character][:action_1_effect])
      @action_2_effect = (params[:character][:action_2_effect])
      @action_3_effect = (params[:character][:action_3_effect])
      @action_4_effect = (params[:character][:action_4_effect])

      @main_image = params[:character][:main_image]
    end
    
    #binding.pry
  end

  def edit_creator
    @character = Character.find_by_name(params[:name])
  end

  def update_creator
    character = Character.find_by_name(params[:name])
    character.creator = params[:transformation]["creator"]
    character.transformation.creator = params[:transformation]["creator"]
    character.save
    redirect_to characters_path(:name => character.name)
  end

  def example
    @character = Character.find_by_name("Ragnar the Warrior")
  end

  def change_order
    if params[:order_type].nil? || params[:origin].nil?
      flash[:alert] = "There was an Problem with Switching the Order. Please Try Again."
      redirect_to game_rules_path
    else
      session[:order] = params[:order_type]
      origin = params[:origin]
      if (origin == "single")
        redirect_to character_character_select_ai_path
      elsif (origin == "choose_opponent")
        redirect_to select_opponent_ai_path(:name => params[:name]), :method => :post
      elsif (origin == "multiplayer")
        redirect_to multiplayer_select_character_path(:player_name => params[:player_name], :invite_id => params[:invite_id], :character => params[:character], :rules => params[:rules], :pref => params[:pref])
      else
        flash[:alert] = "There was a Problem with Switching the Order. Please Try Again."
        redirect_to game_rules_path
      end
    end
  end

  def upvote
    recent = current_user.upvote_checker
    if recent.nil?
      recent = ""
      current_user.upvote_checker = ""
    end
    c = Character.find_by_name(params[:name])
    if c.nil?
      flash[:alert] = "The Character Could not be found."
      redirect_to game_rules_path
    else
      if recent.include?(params[:name])
        flash[:alert] = "You cannot upvote the same character more than once."
      else
        recent = recent + " #{params[:name]}"
        current_user.upvote_checker = recent
        current_user.save
        c.upvotes = c.upvotes + 1
        c.transformation.upvotes = c.transformation.upvotes + 1
        c.transformation.save
        c.save
        flash[:notice] = "#{c.name} Upvoted!"
      end
      redirect_to characters_path(:name => params[:name])
    end
  end

  def set_upvotes_to_0
    all_characters = Character.all
    all_characters.each do |character|
      character.upvotes = 0
      if character.transformation.nil?
      
      else
        character.transformation.upvotes = 0
        character.transformation.save
      end
      character.save
    end
    #binding.pry
    redirect_to game_rules_path
  end

  def create

    x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    player1_username = z["username"]
    @valid = true
   
    @string1 = ""
    @string2 = ""
    @string3 = ""
    @string4 = ""
    @string5 = ""
    @string6 = ""
    @string7 = ""
    @string8 = ""
    @string9 = ""
    @string10 = ""
    @string11 = ""
    @string12 = ""
    @string13 = ""
    @string14 = ""
    @string15 = ""

    #binding.pry

    @name = params[:character][:name]
    @description = params[:character][:description]
    @description = word_wrap(@description)
    @max_hp = params[:character][:max_hp].to_i
    @max_mp = params[:character][:max_mp].to_i
    @base_attack = params[:character][:base_attack].to_i
    @base_power = params[:character][:base_power].to_i
    @base_defense = params[:character][:base_defense].to_i
    @base_armor = params[:character][:base_armor].to_i

    @action_1_name = params[:character][:action_1_name]
    @action_1_flavor = params[:character][:action_1_flavor]
    @action_1_rules = params[:character][:action_1_rules]
    @action_1_id = Character::getIDnum(@action_1_rules)

    @action_2_name = params[:character][:action_2_name]
    @action_2_flavor = params[:character][:action_2_flavor]
    @action_2_rules = params[:character][:action_2_rules]
    @action_2_id = Character::getIDnum(@action_2_rules)

    @action_3_name = params[:character][:action_3_name]
    @action_3_flavor = params[:character][:action_3_flavor]
    @action_3_rules = params[:character][:action_3_rules]
    @action_3_id = Character::getIDnum(@action_3_rules)

    @action_4_name = params[:character][:action_4_name]
    @action_4_flavor = params[:character][:action_4_flavor]
    @action_4_rules = params[:character][:action_4_rules]
    @action_4_id = Character::getIDnum(@action_4_rules)

    @summon_name = params[:character][:summon_name]
    @summon_picture = params[:character][:summon_picture]
    @summon_attack = params[:character][:summon_attack] 

    @basic_effect = Character::get_picture_name(params[:character][:basic_effect])
    @action_1_effect = Character::get_picture_name(params[:character][:action_1_effect])
    @action_2_effect = Character::get_picture_name(params[:character][:action_2_effect])
    @action_3_effect = Character::get_picture_name(params[:character][:action_3_effect])
    @action_4_effect = Character::get_picture_name(params[:character][:action_4_effect])

    @main_image = params[:character][:main_image]
    @actions = @action_1_name + ", " + @action_2_name + ", " + @action_3_name + ", " + @action_4_name
    #binding.pry

    if(!Character.find_by_name(@name).nil?)
      @valid = false
      @string15 = "That character already exists"
    else
      if(@name.blank?)
        @valid = false
        @string1 = "A name must be entered;\n"
      end
      if(@description.blank?)
        @valid = false
        @string2 = "A description must be entered;\n"
      end
      if(@action_1_name.blank?)
        @valid = false
        @string3 = "A 1st Action Name must be entered;\n"
      end
      if(@action_1_flavor.blank?)
        @valid = false
        @string4 = "A 1st Action Description must be entered;\n"
      end
      if(@action_2_name.blank?)
        @valid = false
        @string5 = "A 2nd Action Name must be entered;\n"
      end
      if(@action_2_flavor.blank?)
        @valid = false
        @string6 = "A 2nd Action Description must be entered;\n"
      end
      if(@action_3_name.blank?)
        @valid = false
        @string7 = "A 3rd Action Name must be entered;\n"
      end
      if(@action_3_flavor.blank?)
        @valid = false
        @string8 = "A 3rd Action Description must be entered;\n"
      end
      if(@action_4_name.blank?)
        @valid = false
        @string9 = "A 4th Action Name must be entered;\n"
      end
      if(@action_4_flavor.blank?)
        @valid = false
        @string10 = "A 4th Action Description must be entered;\n"
      end
      if(@main_image.blank?)
        @valid = false
        @string11 = "A URL for the character image must be entered;\n"
      end
      if((@max_hp + @max_mp)>150)
        @valid = false
        @string12 = "Sum of Maximum HP and MP must be less than 150;\n"
      end
      if((@base_attack + @base_power + @base_defense + @base_armor)>21)
        @valid = false
        @string13 = "Sum of base power, attack, defense and armor must be less than 21;\n"
      end
      if(@action_1_rules == @action_2_rules || @action_1_rules == @action_3_rules || @action_1_rules == @action_4_rules || @action_2_rules == @action_3_rules || @action_2_rules == @action_4_rules || @action_3_rules == @action_4_rules)
        @valid = false
        @string14 = "The rules selected for each action must be different;\n"
      end 
    end

    if(@valid == false)
      flash[:alert] = "ERROR: " + @string1+@string2+@string3+@string4+@string5+@string6+@string7+@string8+@string9+@string10+@string11+@string12+@string13+@string14+@string15
      redirect_to new_character_path(:character => params[:character])
    else
      create_hash = {:name => @name, :description => @description, :max_hp => @max_hp, :max_mp => @max_mp, :base_attack => @base_attack, :base_power => @base_power, :base_defense => @base_defense, :base_armor => @base_armor, :actions => @actions, :main_image => @main_image, :action_1_id => @action_1_id, :action_1_name => @action_1_name, :action_1_flavor => @action_1_flavor, :action_1_rules => @action_1_rules, :action_2_id => @action_2_id, :action_2_name => @action_2_name, :action_2_flavor => @action_2_flavor, :action_2_rules => @action_2_rules, :action_3_id => @action_3_id, :action_3_name => @action_3_name, :action_3_flavor => @action_3_flavor, :action_3_rules => @action_3_rules, :action_4_id => @action_4_id, :action_4_name => @action_4_name, :action_4_flavor => @action_4_flavor, :action_4_rules => @action_4_rules, :summon_name => @summon_name, :summon_attack => @summon_attack, :summon_picture => @summon_picture, :creator => player1_username, :upvotes => 0, :basic_effect => @basic_effect, :effect1 => @action_1_effect, :effect2 => @action_2_effect, :effect3 => @action_3_effect, :effect4 => @action_4_effect}
      #binding.pry
      Character.create!(create_hash)
      redirect_to select_num_stages_path(:character_name => @name)
    end
  end

  def index
    nm = params[:name]
    #binding.pry
    @character = Character.find_by_name(nm)#
    if @character.nil?
      flash[:alert] = "The Character Could Not be Found."
      redirect_to game_rules_path
    else
      if (@character.transformation.nil?)
        flash[:alert] = "This Character Has No Associated Transformation. He cannot be played until he does. Thank you!"
        @tag_list = "THIS CHARACTER HAS NO ASSOCIATED TRANSFORMATION!!! If you are the Creator, please click 'View Profile' and then 'Update Transformation' to give him a Transformation. Thank you!"
      else
        @tag_list = Transformation::get_tag_list(@character.transformation)
      end
      search_hash = {}
      search_hash[:character] = @character.name
      @comments = Comment.where(search_hash).limit(5)
      @comments = @comments.order('created_at DESC')
    end

    #binding.pry
    #binding.pry
    #redirect_to characters_show_path(:name => nm)
    #binding.pry
  end

  def update
     x = session["warden.user.user.key"]
    y = User.find(x[0])
    z = y[0]
    player1_username = z["username"]
    @valid = true
   
    @string1 = ""
    @string2 = ""
    @string3 = ""
    @string4 = ""
    @string5 = ""
    @string6 = ""
    @string7 = ""
    @string8 = ""
    @string9 = ""
    @string10 = ""
    @string11 = ""
    @string12 = ""
    @string13 = ""
    @string14 = ""
    @string15 = ""

    @name = params[:character][:name]
    @description = params[:character][:description]
    @description = word_wrap(@description)
    @max_hp = params[:character][:max_hp].to_i
    @max_mp = params[:character][:max_mp].to_i
    @base_attack = params[:character][:base_attack].to_i
    @base_power = params[:character][:base_power].to_i
    @base_defense = params[:character][:base_defense].to_i
    @base_armor = params[:character][:base_armor].to_i

    @action_1_name = params[:character][:action_1_name]
    @action_1_flavor = params[:character][:action_1_flavor]
    @action_1_rules = params[:character][:action_1_rules]
    @action_1_id = Character::getIDnum(@action_1_rules)

    @action_2_name = params[:character][:action_2_name]
    @action_2_flavor = params[:character][:action_2_flavor]
    @action_2_rules = params[:character][:action_2_rules]
    @action_2_id = Character::getIDnum(@action_2_rules)

    @action_3_name = params[:character][:action_3_name]
    @action_3_flavor = params[:character][:action_3_flavor]
    @action_3_rules = params[:character][:action_3_rules]
    @action_3_id = Character::getIDnum(@action_3_rules)

    @action_4_name = params[:character][:action_4_name]
    @action_4_flavor = params[:character][:action_4_flavor]
    @action_4_rules = params[:character][:action_4_rules]
    @action_4_id = Character::getIDnum(@action_4_rules)

    @summon_name = params[:character][:summon_name]
    @summon_picture = params[:character][:summon_picture]
    @summon_attack = params[:character][:summon_attack] 

    @main_image = params[:character][:main_image]
    @actions = @action_1_name + ", " + @action_2_name + ", " + @action_3_name + ", " + @action_4_name
    #binding.pry
    @basic_effect = Character::get_picture_name(params[:character][:basic_effect])
    @action_1_effect = Character::get_picture_name(params[:character][:effect1])
    @action_2_effect = Character::get_picture_name(params[:character][:effect2])
    @action_3_effect = Character::get_picture_name(params[:character][:effect3])
    @action_4_effect = Character::get_picture_name(params[:character][:effect4])
    #if(!Character.find_by_name(@name).nil?)
      #@valid = false
      #@string15 = "That character already exists"
    #else
    

    if(@name.blank?)
      @valid = false
      @string1 = "A name must be entered;\n"
    end
    if(@description.blank?)
      @valid = false
      @string2 = "A description must be entered;\n"
    end
    if(@action_1_name.blank?)
      @valid = false
      @string3 = "A 1st Action Name must be entered;\n"
    end
    if(@action_1_flavor.blank?)
      @valid = false
      @string4 = "A 1st Action Description must be entered;\n"
    end
    if(@action_2_name.blank?)
      @valid = false
      @string5 = "A 2nd Action Name must be entered;\n"
    end
    if(@action_2_flavor.blank?)
      @valid = false
      @string6 = "A 2nd Action Description must be entered;\n"
     end
    if(@action_3_name.blank?)
      @valid = false
      @string7 = "A 3rd Action Name must be entered;\n"
    end
    if(@action_3_flavor.blank?)
      @valid = false
      @string8 = "A 3rd Action Description must be entered;\n"
    end
    if(@action_4_name.blank?)
      @valid = false
      @string9 = "A 4th Action Name must be entered;\n"
    end
    if(@action_4_flavor.blank?)
      @valid = false
      @string10 = "A 4th Action Description must be entered;\n"
    end
    if(@main_image.blank?)
      @valid = false
      @string11 = "A URL for the character image must be entered;\n"
    end
    if((@max_hp + @max_mp)>150)
      @valid = false
      @string12 = "Sum of Maximum HP and MP must be less than 150;\n"
    end
    if((@base_attack + @base_power + @base_defense + @base_armor)>21)
      @valid = false
      @string13 = "Sum of base power, attack, defense and armor must be less than 21;\n"
    end
    if(@action_1_rules == @action_2_rules || @action_1_rules == @action_3_rules || @action_1_rules == @action_4_rules || @action_2_rules == @action_3_rules || @action_2_rules == @action_4_rules || @action_3_rules == @action_4_rules)
      @valid = false
      @string14 = "The rules selected for each action must be different;\n"
    end 

    if(@valid == false)
      flash[:alert] = "ERROR: " + @string1+@string2+@string3+@string4+@string5+@string6+@string7+@string8+@string9+@string10+@string11+@string12+@string13+@string14+@string15
      redirect_to character_edit_path(:character => params[:character])
    else
      create_hash = {:name => @name,:description => @description, :max_hp => @max_hp, :max_mp => @max_mp, :base_attack => @base_attack, :base_power => @base_power, :base_defense => @base_defense, :base_armor => @base_armor, :actions => @actions, :main_image => @main_image, :action_1_id => @action_1_id, :action_1_name => @action_1_name, :action_1_flavor => @action_1_flavor, :action_1_rules => @action_1_rules, :action_2_id => @action_2_id, :action_2_name => @action_2_name, :action_2_flavor => @action_2_flavor, :action_2_rules => @action_2_rules, :action_3_id => @action_3_id, :action_3_name => @action_3_name, :action_3_flavor => @action_3_flavor, :action_3_rules => @action_3_rules, :action_4_id => @action_4_id, :action_4_name => @action_4_name, :action_4_flavor => @action_4_flavor, :action_4_rules => @action_4_rules, :summon_name => @summon_name, :summon_attack => @summon_attack, :summon_picture => @summon_picture, :basic_effect => @basic_effect, :effect1 => @action_1_effect, :effect2 => @action_2_effect, :effect3 => @action_3_effect, :effect4 => @action_4_effect}
      #binding.pry
      current_character = Character.find_by_name(@name)
      current_character.update_attributes(create_hash)
      flash[:notice] = "#{@name} has been updated successfully."
      current_character.save
      redirect_to  view_path(:current => true)
    end
  end

  def destroy
    character = Character.find(params[:id])
    character_name = character.name
    Transformation.delete(character.transformation)
    character.destroy
    search_hash = {:player1_character => character_name}
    delete_list1 = Game.where(search_hash)
    delete_list1.each do |game|
      player1 = User.find_by_username(game.player1)
      player2 = User.find_by_username(game.player2)
      player1.currentgame = nil
      player1.save
      player2.currentgame = nil
      player2.save
      game.destroy
    end

    search_hash = {:player2_character => character_name}
    delete_list2 = Game.where(search_hash)
    delete_list2.each do |game|
      player1 = User.find_by_username(game.player1)
      player2 = User.find_by_username(game.player2)
      player1.currentgame = nil
      player1.save
      player2.currentgame = nil
      player2.save
      game.destroy
    end
    flash[:notice] = "Character deleted"
    redirect_to character_admin_path 
  end

  def admin
    if current_user.is_admin
      @characters = Character.all
      #render :template => "/game/admin"
    else
      redirect_to game_rules_path
    end
 end

  def character_select_ai
    #binding.pry
    if current_user.favorites_list.nil? 
      current_user.favorites_list = ""
      current_user.save
    end
    if params["transformation"].nil? && session["preferences"].nil?
      search_hash = {}
      search_hash["is_completed"] = true
      @characters = Transformation.where(search_hash)
      #Transformation::initial_button_preferences
      if session["button_pref"].nil?
        button_hash = {}
        button_hash['is_adult'] = true
        button_hash['is_M2F'] = true
        button_hash['is_F2M'] = true
        button_hash['is_race_change'] = true
        button_hash['is_age_reg'] = true
        button_hash['is_age_pro'] = true
        button_hash['is_furry'] = true
        button_hash['is_animal'] = true
        button_hash['is_futa'] = true
        button_hash['is_mind'] = true
        button_hash['is_bdsm'] = true
        button_hash['is_pregnant'] = true
        button_hash['is_inanimate'] = true
        button_hash['is_growth'] = true
        button_hash['is_shrink'] = true
        button_hash['is_weight_gain'] = true
        button_hash['is_fantasy'] = true
        button_hash['is_bizarre'] = true
        button_hash['is_bimbo'] = true
        button_hash['is_robot'] = true
        button_hash['is_monster_girl'] = true
        button_hash['is_completed'] = true
        button_hash['is_full_picture'] = true
        session["button_pref"] = button_hash
      end
      @button_hash = session["button_pref"]
    else
      #@characters = Transformation.all
      if params["transformation"].nil?
        preferences = session["preferences"]
        @pref2 = session["pref2"]
        params["#{@pref2}"] = @pref2
        @button_hash = session["button_pref"]
        if @button_hash.nil?
          @button_hash = {}
        end
        if params[:all_button].nil?
          preferences.each do |key, value|
            if value == "0"
              @button_hash[key] = false
            elsif value == "1"
              @button_hash[key] = true
            end
          end
        end
        #binding.pry
        session["button_pref"] = button_hash
      else
        preferences = params["transformation"]
        session["preferences"] = preferences
        #Transformation::button_hash_editor(preferences)
        if !params["Edit Preferences: Excluding Search"].nil? 
            session["pref2"] = "Edit Preferences: Excluding Search"
        elsif !params["Edit Preferences: Including Search"].nil? 
            session["pref2"] = "Edit Preferences: Including Search"
        end
        @button_hash = session["button_pref"]
        if @button_hash.nil?
          @button_hash = {}
        end
        preferences.each do |key, value|
          if value == "0"
            @button_hash[key] = false
          elsif value == "1"
            @button_hash[key] = true
          end
        end
      end

      search_hash = {}
      preferences.each do |key, value|
        if value == "0"
          if !params["Edit Preferences: Excluding Search"].nil? 
            search_hash[key] = false
          end
        elsif value == "1"
          if  !params["Edit Preferences: Including Search" ].nil?
            search_hash[key] = true
          end
        end
      end
      #binding.pry
      if !params["Edit Preferences: Excluding Search"].nil? 
        if (search_hash.has_key?("is_completed"))
          search_hash.except!("is_completed")
        else
          search_hash["is_completed"] = true
        end
        if (search_hash.has_key?("is_full_picture"))
          search_hash.except!("is_full_picture")
        else
          search_hash["is_full_picture"] = true
        end
      else
        if (search_hash.has_key?("is_completed"))
          #search_hash.except!("is_completed")
        else
          search_hash.except!("is_completed")
        end
        if (search_hash.has_key?("is_full_picture"))
          #search_hash.except!("is_full_picture")
        else
          search_hash.except!["is_full_picture"]
          #search_hash["is_full_picture"] = true
        end
      end
      #@characters = Transformation.where(search_hash).order("upvotes DESC")
      @characters = Transformation.where(search_hash)
      if session[:order].nil?
        session[:order] = "created_at DESC"
      end
      @characters = @characters.reorder(session[:order])
      #binding.pry
      #@characters = Hash[@characters.sort_by{|k,v|}, v[:upvotes]]
     
      #binding.pry
      if @characters.empty?
        flash[:notice] = "No Results Found"
      end

      @rules_hash = search_hash
      #binding.pry
    end
  end

  def select_opponent
    if current_user.favorites_list.nil? 
      current_user.favorites_list = ""
      current_user.save
    end
    @player1_character = params[:name]
    #binding.pry
    if params["transformation"].nil? && session["preferences"].nil?
      search_hash = {}
      search_hash["is_completed"] = true
      @characters = Transformation.where(search_hash)
      #Transformation::initial_button_preferences
      button_hash = {}
      button_hash['is_adult'] = true
      button_hash['is_M2F'] = true
      button_hash['is_F2M'] = true
      button_hash['is_race_change'] = true
      button_hash['is_age_reg'] = true
      button_hash['is_age_pro'] = true
      button_hash['is_furry'] = true
      button_hash['is_animal'] = true
      button_hash['is_futa'] = true
      button_hash['is_mind'] = true
      button_hash['is_bdsm'] = true
      button_hash['is_pregnant'] = true
      button_hash['is_inanimate'] = true
      button_hash['is_growth'] = true
      button_hash['is_shrink'] = true
      button_hash['is_weight_gain'] = true
      button_hash['is_fantasy'] = true
      button_hash['is_bizarre'] = true
      button_hash['is_bimbo'] = true
      button_hash['is_robot'] = true
      button_hash['is_monster_girl'] = true
      button_hash['is_completed'] = true
      button_hash['is_full_picture'] = true
      if session["button_pref"].nil?
        session["button_pref"] = button_hash
      end
      @button_hash = button_hash
    else
      #@characters = Transformation.all
      if params["transformation"].nil?
        preferences = session["preferences"]
        @pref2 = session["pref2"]
        params["#{@pref2}"] = @pref2
        @button_hash = session["button_pref"]
        if @button_hash.nil?
          @button_hash = {}
        end
        if params[:all_button].nil?
          preferences.each do |key, value|
            if value == "0"
              @button_hash[key] = false
            elsif value == "1"
              @button_hash[key] = true
            end
          end
       end
        session["button_pref"] = button_hash
      else
        preferences = params["transformation"]
        session["preferences"] = preferences
        #Transformation::button_hash_editor(preferences)
        if !params["Edit Preferences: Excluding Search"].nil? 
            session["pref2"] = "Edit Preferences: Excluding Search"
        elsif !params["Edit Preferences: Excluding Search"].nil? 
            session["pref2"] = "Edit Preferences: Excluding Search"
        end
        @button_hash = session["button_pref"]
        if @button_hash.nil?
          @button_hash = {}
        end
        preferences.each do |key, value|
          if value == "0"
            @button_hash[key] = false
          elsif value == "1"
            @button_hash[key] = true
          end
        end
      end

      search_hash = {}
      #
      preferences.each do |key, value|
        if value == "0"
          if !params["Edit Preferences: Excluding Search"].nil? 
            search_hash[key] = false
          end
        elsif value == "1"
          if  !params["Edit Preferences: Including Search" ].nil?
            search_hash[key] = true
          end
        end
      end
      #binding.pry
      if !params["Edit Preferences: Excluding Search"].nil? 
        if (search_hash.has_key?("is_completed"))
          search_hash.except!("is_completed")
        else
          search_hash["is_completed"] = true
        end
        if (search_hash.has_key?("is_full_picture"))
          search_hash.except!("is_full_picture")
        else
          search_hash["is_full_picture"] = true
        end
      else
        if (search_hash.has_key?("is_completed"))
          #search_hash.except!("is_completed")
        else
          search_hash.except!("is_completed")
        end
        if (search_hash.has_key?("is_full_picture"))
          #search_hash.except!("is_full_picture")
        else
          search_hash.except!["is_full_picture"]
          #search_hash["is_full_picture"] = true
        end
      end
      #@characters = Transformation.where(search_hash).order("upvotes DESC")
      @characters = Transformation.where(search_hash).order("created_at DESC")
      #@characters = Hash[@characters.sort_by{|k,v|}, v[:upvotes]]
      if session[:order].nil?
        session[:order] = "created_at DESC"
      end
      @characters = @characters.reorder(session[:order])
      #binding.pry
      if @characters.empty?
        flash[:notice] = "No Results Found"
      end

      @rules_hash = search_hash
      #binding.pry
    end
  end

  def edit
    @character = Character.find_by_name(params[:name])
    @effect1 = Character::name_from_picture(@character.effect1)
    @effect2 = Character::name_from_picture(@character.effect2)
    @effect3 = Character::name_from_picture(@character.effect3)
    @effect4 = Character::name_from_picture(@character.effect4)
    @basic_effect = Character::name_from_picture(@character.basic_effect)
   #binding.pry

  end

  def show
    #binding.pry
    @character = Character.find_by_name(params[:name])
    if @character.nil?
      flash[:notice] = "This Character Does Not Have an Associated Transformation"
      redirect_to character_admin_path
    else
      @tag_list = Transformation::get_tag_list(@character.transformation)
    end
  end

  def check_all_boxes
     button_hash = {}
      button_hash['is_adult'] = true
      button_hash['is_M2F'] = true
      button_hash['is_F2M'] = true
      button_hash['is_race_change'] = true
      button_hash['is_age_reg'] = true
      button_hash['is_age_pro'] = true
      button_hash['is_furry'] = true
      button_hash['is_animal'] = true
      button_hash['is_futa'] = true
      button_hash['is_mind'] = true
      button_hash['is_bdsm'] = true
      button_hash['is_pregnant'] = true
      button_hash['is_inanimate'] = true
      button_hash['is_growth'] = true
      button_hash['is_shrink'] = true
      button_hash['is_weight_gain'] = true
      button_hash['is_fantasy'] = true
      button_hash['is_bizarre'] = true
      button_hash['is_bimbo'] = true
      button_hash['is_robot'] = true
      button_hash['is_monster_girl'] = true
      button_hash['is_completed'] = true
      button_hash['is_full_picture'] = true
      session["button_pref"] = button_hash
      origin = params[:origin]
      if (origin == "single")
        redirect_to character_character_select_ai_path(:all_button => true)
      elsif (origin == "choose_opponent")
        redirect_to select_opponent_ai_path(:name => params[:name], :all_button => true), :method => :post
      elsif (origin == "multiplayer")
        redirect_to multiplayer_select_character_path(:all_button => true, :player_name => params[:player_name], :invite_id => params[:invite_id], :character => params[:character], :rules => params[:rules], :pref => params[:pref])
      else
        flash[:alert] = "There was a Problem Checking All Boxes. Please Try Again."
        redirect_to game_rules_path
      end
  end

  def uncheck_all_boxes
     button_hash = {}
      button_hash['is_adult'] = false
      button_hash['is_M2F'] = false
      button_hash['is_F2M'] = false
      button_hash['is_race_change'] = false
      button_hash['is_age_reg'] = false
      button_hash['is_age_pro'] = false
      button_hash['is_furry'] = false
      button_hash['is_animal'] = false
      button_hash['is_futa'] = false
      button_hash['is_mind'] = false
      button_hash['is_bdsm'] = false
      button_hash['is_pregnant'] = false
      button_hash['is_inanimate'] = false
      button_hash['is_growth'] = false
      button_hash['is_shrink'] = false
      button_hash['is_weight_gain'] = false
      button_hash['is_fantasy'] = false
      button_hash['is_bizarre'] = false
      button_hash['is_bimbo'] = false
      button_hash['is_robot'] = false
      button_hash['is_monster_girl'] = false
      button_hash['is_completed'] = false
      button_hash['is_full_picture'] = false
      session["button_pref"] = button_hash
      origin = params[:origin]
      #binding.pry
      if (origin == "single")
        redirect_to character_character_select_ai_path(:all_button => true)
      elsif (origin == "choose_opponent")
        redirect_to select_opponent_ai_path(:name => params[:name], :all_button => true), :method => :post
      elsif (origin == "multiplayer")
        redirect_to multiplayer_select_character_path(:all_button => true, :player_name => params[:player_name], :invite_id => params[:invite_id], :character => params[:character], :rules => params[:rules], :pref => params[:pref])
      else
        flash[:alert] = "There was a Problem with Unchecking All Boxes. Please Try Again."
        redirect_to game_rules_path
      end
  end
end
