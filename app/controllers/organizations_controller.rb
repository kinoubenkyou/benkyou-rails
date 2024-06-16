class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[ destroy show update ]

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      render json: @organization, status: :created
    else
      render json: @organization.errors, status: :bad_request
    end
  end

  def destroy
    @organization.destroy
    render status: :no_content
  end

  def index
    @organizations = Organization
    @organizations = @organizations.where("lower(code) LIKE ?", "%#{params[:code_search]&.downcase}%") if params[:code_search].present?
    @organizations = @organizations.where("lower(name) LIKE ?", "%#{params[:name_search]&.downcase}%") if params[:name_search].present?
    @organizations = @organizations.order(params[:order]) if params[:order].present?
    render json: @organizations.page(params[:page]).per(params[:per])
  end

  def show
    render json: @organization
  end

  def update
    render json: @organization.errors, status: :bad_request unless @organization.update(organization_params)
  end

  private

  def organization_params
    params.permit(:code, :name)
  end

  def set_organization
    @organization = Organization.find_by(id: params[:id])
    render status: :not_found if @organization.nil?
  end
end
