require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/properties", type: :request do
  describe "GET #index" do
    subject(:get_properties) { get properties_path, as: :json }

    context "when there is data to return" do
      let!(:properties_list) { create_list(:property, 10) }

      it "renders a successful response" do
        get_properties
        expect(response).to be_successful
      end

      it "returns the correct items" do
        get_properties
        expect(JSON.parse(response.body, object_class: Property)).to eq(properties_list)
      end
    end

    context "when there is no data to return" do
      it "renders a successful response" do
        get_properties
        expect(response).to be_successful
      end

      it "returns an empty array" do
        get_properties
        expect(JSON.parse(response.body, object_class: Property)).to eq([])
      end
    end
  end

  describe "GET #show" do
    let!(:property) { create(:property) }

    context "when there is data to return" do
      subject(:get_property) { get "/properties/#{property.id}", as: :json }

      it "renders a successful response" do
        get_property
        expect(response).to be_successful
      end

      it "returns the correct item" do
        get_property
        expect(JSON.parse(response.body, object_class: Property)).to eq(property)
      end
    end

    context "when there is no data to return" do
      subject(:get_property) { get '/properties/839d5ba7-6086-4521-a034-f99e7752b063', as: :json }

      it "raises ActiveRecord::RecordNotFound" do
        expect { get_property }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:post_params) { attributes_for(:property) }
      subject(:post_property) {
        post properties_url,
             params: { property: post_params }, as: :json
      }

      it "creates a new property" do
        expect { post_property }.to change(Property, :count).by(1)
      end

      it "renders a created response" do
        post_property
        expect(response).to have_http_status(:created)
      end

      it "renders a JSON response with the correct name" do
        post_property
        expect(JSON.parse(response.body, object_class: Property).name).to eq(post_params[:name])
      end
    end

    context "with invalid parameters" do
      let(:post_invalid_params) { attributes_for(:property, name: nil) }

      subject(:post_invalid_property) {
        post properties_url,
        params: { property: post_invalid_params }, as: :json
      }

      context "with nil name" do
        it "does not create a new property" do
          expect { post_invalid_property }.to change(Property, :count).by(0)
        end

        it "renders a JSON response with status 422" do
          post_invalid_property
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "renders a JSON response with errors for the new property" do
          post_invalid_property
          expect(JSON.parse(response.body, object_class: Property).name).to eq("[\"can't be blank\"]")
        end
      end

      context "with empty params" do
        subject(:post_empty_params) {
          post properties_url,
          params: { }, as: :json
        }

        it "raises ActionController::ParameterMissing" do
          expect { post_empty_params }.to raise_error(ActionController::ParameterMissing)
        end
      end
    end
  end

  describe "PATCH #update" do
    let!(:property) { create(:property) }

    context "with valid parameters" do
      let(:patch_params) { attributes_for(:property) }
      subject(:patch_property) {
        patch "/properties/#{property.id}",
            params: { property: patch_params }, as: :json
      }

      it "does not create a new property" do
        expect { patch_property }.to change(Property, :count).by(0)
      end

      it "does update a property" do
        patch_property
        expect(Property.find(property.id).created_at).not_to eq(Property.find(property.id).updated_at)
      end

      it "renders a successful response" do
        patch_property
        expect(response).to be_successful
      end

      it "renders a JSON response with the changed name" do
        patch_property
        expect(JSON.parse(response.body, object_class: Property).name).to eq(patch_params[:name])
      end
    end

    context "with invalid parameters" do
      subject(:patch_invalid_property) {
        patch "/properties/#{property.id}",
        params: { property: patch_invalid_params }, as: :json
      }

      context "with nil name" do
        let(:patch_invalid_params) { attributes_for(:property, name: nil) }

        it "does not update a property" do
          expect { patch_invalid_property }.to change(Property, :count).by(0)
        end

        it "renders a JSON response status 422" do
          patch_invalid_property
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "does not update original property" do
          patch_invalid_property
          expect(Property.find(property.id)).to eq(property)
        end

        it "renders a JSON response with errors for the updated property" do
          patch_invalid_property
          expect(JSON.parse(response.body, object_class: Property).name).to eq("[\"can't be blank\"]")
        end
      end

      context "with empty params" do
        subject(:patch_invalid_property) {
          patch "/properties/#{property.id}",
          params: { }, as: :json
        }

        it "raises ActionController::ParameterMissing" do
          expect { patch_invalid_property }.to raise_error(ActionController::ParameterMissing)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:property) { create(:property) }

    context "when there is data to delete" do
      subject(:delete_property) { delete "/properties/#{property.id}", as: :json }

      it "renders a successful response" do
        delete_property
        expect(response).to be_successful
      end

      it "returns a blank body" do
        delete_property
        expect(response.body).to eq("")
      end
    end

    context "when there is no data to delete" do
      subject(:delete_property) { delete '/properties/839d5ba7-6086-4521-a034-f99e7752b063', as: :json }

      it "raises ActiveRecord::RecordNotFound" do
        expect { delete_property }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
