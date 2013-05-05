module StaticPagesHelper
  def active_class(name)
    "class=active" if params[:action] == name
  end
end
