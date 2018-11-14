class EntryController < ApplicationController

  before_action :move_to_index, except: [:index]

  def index
    @entries = Entry.all.order('id DESC').page(params[:page]).per(5)
  end


  def new
    @entry = Entry.new
  end

  def create
    transform(params)

    Entry.create(entry_params)
    redirect_to controller: :entry ,action: :index
  end

  def update
    entry = Entry.find(params[:id])
    if entry.user_id == current_user.id
      entry.update(entry_params)
    end
    redirect_to controller: :entry ,action: :index
  end

 def destroy
    entry = Entry.find(params[:id])
    entry.destroy if entry.user_id == current_user.id
  end

  def edit
    @entry = Entry.find(params[:id])
  end


  private

  def entry_params
    params.require(:entry).permit(:title,:body).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def transform(params)
    if params[:entry][:title].match(/死/) ||params[:entry][:body].match(/死/)
    params[:entry][:title] = "君が死にたいと思う今日は"
    params[:entry][:body] = "誰かが生きたかった明日なんだ"
  end
end

end


