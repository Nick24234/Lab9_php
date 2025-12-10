require 'swagger_helper'

RSpec.describe 'api/v1/transfers', type: :request do
  path '/api/v1/transfers' do
    get('list transfers') do
      tags 'Transfers'
      produces 'application/json'

      response(200, 'successful') do
        run_test!
      end
    end

    post('create transfer') do
      tags 'Transfers'
      consumes 'application/json'
      parameter name: :transfer, in: :body, schema: {
        type: :object,
        properties: {
          sender_id: { type: :integer },
          receiver_id: { type: :integer },
          amount: { type: :number, format: :float },
          currency: { type: :string },
          status: { type: :string }
        },
        required: %w[sender_id receiver_id amount currency status]
      }

      response(201, 'created') do
        let(:transfer) do
          {
            sender_id: 1,
            receiver_id: 2,
            amount: 10.5,
            currency: 'USD',
            status: 'pending'
          }
        end
        run_test!
      end
    end
  end
end

