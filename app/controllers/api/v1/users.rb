module API
  module V1
    class Contacts < Grape::API
      include API::V1::Defaults
      
      resource :users do
        desc "Return all users"
        get "", root: :contacts do
          User.all
        end

        desc "Return a user"
        params do 
          requires :id, type: String, desc: "ID of user"
        end
        get ":id", root: "contact" do
          User.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
