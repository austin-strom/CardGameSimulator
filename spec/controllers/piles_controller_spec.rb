require 'rails_helper'
require 'spec_helper'

describe PilesController do
  describe 'transferring cards from piles' do
    it 'should redirect to piles home page if source pile is invalid' do
      params = {
          pile: {source_pile: nil}
      }
      post :show, params
      expect(response).to redirect_to (:root)
    end
    it 'should transfer card from source pile to destination pile' do
      params = {
          pile: {source_pile: "Deck"}
      }
      post :show, params
      expect(response).to render_template('show')
    end
  end
end