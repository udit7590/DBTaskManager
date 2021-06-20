ActiveCampaign::Client.class_eval do
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
