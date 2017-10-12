class WelcomeController < ApplicationController
  def index
    @works = Work.all

    spotlight = rand(Work.count)
    @rand_work = Work.offset(spotlight).first
  end
end
