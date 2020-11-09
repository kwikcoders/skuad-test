# frozen_string_literal: false

# Drivers Controller
module Api
  module V1
    class DriversController < ApplicationController

      def create
        driver = Driver.create(driver_params)
        if driver.save
          render json: driver, status: :created
        else
          render json: { status: 'failure', reason: 'Something went Wrong' }, status: 400
        end
      end

      def save_location
        driver = Driver.find_by(id: params[:id])
        if driver.update(latitude: params[:latitude], longitude: params[:longitude])
          render json: { status: 'success' }, status: 202
        else
          render json: { status: 'failure', reason: 'Something went Wrong' }, status: 400
        end
      end

      def available_cabs
        begin
          users = []
          Driver.all.each do |user|
            find_distance = distance(user.latitude, user.longitude, params[:latitude], params[:longitude])
            if find_distance < 100.0
              users << user
            end
          end
          if users.empty?
            render json: { message: 'No cabs available!' }, status: :ok
          else
            render json: { available_cabs: users }, status: :ok
          end
        rescue StandardError => e
          render json: { status: 'failure', reason: 'Something went Wrong' }, status: 400
        end
      end

      private

      def driver_params
        params.permit(:name, :email, :phone_number,
                      :license_number, :car_number)
      end

      def distance(lat2, lng2, lat1, lng1)
        lng1 = lng1.to_f
        lat1 = lat1.to_f
        res_lat = (lat2 - lat1) * Math::PI / 180
        res_lon = (lng2 - lng1) * Math::PI / 180
        a = Math.sin(res_lat / 2) * Math.sin(res_lat / 2) +
            Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) *
                Math.sin(res_lon / 2) * Math.sin(res_lon / 2)
        c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
        d = 6371 * c
      end

    end
  end
end
