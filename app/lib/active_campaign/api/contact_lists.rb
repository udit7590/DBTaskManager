# frozen_string_literal: true
# NOTE: This is an extension to the Gem as the ContactLists API is not supported by the original gem yet.
#
# Interface to contact tag endpoints
#
# @author Udit Mittal <udit.mittal1990@gmail.com>
#
ActiveCampaign::API.module_eval do
  #
  # Interface to contact tag endpoints
  #
  # @author Udit Mittal <udit.mittal1990@gmail.com>
  #
  module ContactLists
    #
    # Add a list to a contact
    #
    # @param [Hash] params add a list to a contact with this data
    # @param params [String] :contact ID of the contact you're adding the tag to
    # @param params [String] :list ID of the list to be added for the contact
    # @param params [String] :status Set to "1" to subscribe the contact to the list. Set to "2" to unsubscribe the contact from the list.
    # @param params [String] :sourceid Set to "4" when re-subscribing a contact to a list
    #
    # @return [Hash] a hash with the information of the newly created contact list
    #
    def create_contact_list(params)
      post('contactLists', contact_list: params)
    end
  end
end
