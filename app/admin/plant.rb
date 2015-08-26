ActiveAdmin.register Plant do

  permit_params :name

  before_filter :skip_sidebar!, :only => :index

end
