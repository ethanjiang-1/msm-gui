class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    @the_director = Director.new
    @the_director.name = params.fetch("query_name")
    @the_director.dob = params.fetch("query_dob")
    @the_director.bio = params.fetch("query_bio")
    @the_director.image = params.fetch("query_image_url")

    @the_director.save
    redirect_to("/directors")
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    @the_director.destroy

    redirect_to("/directors")
  end

  def update
    the_id = params.fetch("an_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    @the_director.name = params.fetch("query_name")
    @the_director.dob = params.fetch("query_dob")
    @the_director.bio = params.fetch("query_bio")
    @the_director.image = params.fetch("query_image_url")

    @the_director.save

    redirect_to("/directors/#{@the_director.id}")
  end

end
