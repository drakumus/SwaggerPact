#
# Copyright (C) 2018 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

require_relative 'helper'
require_relative '../pact_helper'

describe 'Account Notifications', :pact do
  subject(:notifications_api) { Helper::ApiClient::AccountNotifications.new }

  context 'List Notifications' do
    it 'should return JSON body' do
      canvas_lms_api.given('a user with many notifications').
        upon_receiving('List Notifications').
        with(
          method: :get,
          headers: {
            'Authorization' => 'Bearer some_token',
            'Connection': 'close',
            'Host': PactConfig.mock_provider_service_base_uri,
            'Version': 'HTTP/1.1'
          },
          'path' => "/api/v1/accounts/1/account_notifications",
          query: ''
        ).
        will_respond_with(
          status: 200,
          headers: {
            'Content-Type': 'application/json'
          },
          body: Pact.each_like(
            {
              'subject': 'something',
              'message': 'another',
              'start_at': '2013-08-28T23:59:00-06:00',
              'end_at': '2013-08-28T23:59:00-06:00',
              'icon': 'icon_sent'
            }
          )
        )

      response = notifications_api.list_account_notifications(1)
      expect(response[0]['subject']).to eq 'something'
      expect(response[0]['message']).to eq 'another'
    end
  end

  context 'Show Notification' do
    it 'should return JSON body' do
      canvas_lms_api.given('a user with many notifications').
        upon_receiving('Show Notification').
        with(
          method: :get,
          headers: {
            'Authorization' => 'Bearer some_token',
            'Connection': 'close',
            'Host': PactConfig.mock_provider_service_base_uri,
            'Version': 'HTTP/1.1'
          },
          'path' =>
            "/api/v1/accounts/1/account_notifications/1",
          query: ''
        ).
        will_respond_with(
          status: 200,
          headers: {
            'Content-Type': 'application/json'
          },
          body:
          {
            'subject': 'something',
            'message': 'another',
            'start_at': '2013-08-28T23:59:00-06:00',
            'end_at': '2013-08-28T23:59:00-06:00',
            'icon': 'icon_sent'
          }
        )

      response = notifications_api.show_account_notification(1, 1)
      expect(response['subject']).to eq 'something'
      expect(response['message']).to eq 'another'
    end
  end

  context 'Delete Notification' do
    it 'should return JSON body' do
      canvas_lms_api.given('a user with many notifications').
        upon_receiving('Delete Notification').
        with(
          method: :delete,
          headers: {
            'Authorization' =>
              'Bearer some_token',
            'Connection': 'close',
            'Host': PactConfig.mock_provider_service_base_uri,
            'Version': 'HTTP/1.1'
          },
          'path' =>
            "/api/v1/accounts/1/account_notifications/3",
          query: ''
        ).
        will_respond_with(
          status: 200,
          body:
          {
            'subject': 'something',
            'message': 'another',
            'start_at': '2013-08-28T23:59:00-06:00',
            'end_at': '2013-08-28T23:59:00-06:00',
            'icon': 'icon_sent'
          }
        )

      response = notifications_api.remove_account_notification(1, 3)
      expect(response['subject']).to eq 'something'
      expect(response['message']).to eq 'another'
    end
  end
end
