# frozen_string_literal: true
module Factory
  class Board::OrgansController < Org::Board::OrgansController
    before_action :set_provide
    before_action :set_organ, only: [:show, :edit, :update, :destroy, :actions, :bind]

    def create
      @member = @organ.members.build(identity: current_authorized_token.identity)
      @member.wechat_openid = current_authorized_token.uid if @member.respond_to? :wechat_openid

      if @organ.save
        @provide.update(provider_id: @organ.id)
        render :create, locals: { model: @organ }
      else
        render :new, locals: { model: @organ }, status: :unprocessable_entity
      end
    end

    def bind
      @provide.update provider_id: @organ_id
    end

    private
    def set_provide
      @provide = Provide.find_by invite_token: params[:invite_token]
    end

  end
end
