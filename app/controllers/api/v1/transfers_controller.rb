module Api
  module V1
    class TransfersController < BaseController
      before_action :set_transfer, only: %i[show update destroy]

      def index
        render json: Transfer.all
      end

      def show
        render json: @transfer
      end

      def create
        transfer = Transfer.new(transfer_params)
        if transfer.save
          render json: transfer, status: :created
        else
          render json: transfer.errors, status: :unprocessable_entity
        end
      end

      def update
        if @transfer.update(transfer_params)
          render json: @transfer
        else
          render json: @transfer.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @transfer.destroy
        head :no_content
      end

      private

      def set_transfer
        @transfer = Transfer.find(params[:id])
      end

      def transfer_params
        params.require(:transfer).permit(:sender_id, :receiver_id, :amount, :currency, :status)
      end
    end
  end
end

