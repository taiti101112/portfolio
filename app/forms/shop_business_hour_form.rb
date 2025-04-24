class ShopBusinessHourForm
  include ActiveModel::Model

  ATTRIBUTES = %i[shop_name address phone_number duel_space_available opening_hours official_hp twitter
                  instagram tag_list business_hours_attributes user_id]

  attr_accessor(*ATTRIBUTES)

  validate :validate_business_hours

  def initialize(params = nil, shop = nil)
    if shop
      @shop = shop
      self.shop_name = shop.name
      self.address = shop.address
      self.phone_number = shop.phone_number
      self.duel_space_available = shop.duel_space_available
      self.opening_hours = shop.opening_hours
      self.official_hp = shop.official_hp
      self.twitter = shop.twitter
      self.instagram = shop.instagram
      self.tag_list = shop.tag_list.join(',') if shop.tag_list.present?
      self.business_hours_attributes = shop.business_hours.map do |bh|
        bh.attributes.symbolize_keys.slice(:day_of_week, :opening_time, :closing_time)
      end
    else
      @shop = Shop.new
      self.business_hours_attributes = (0..6).map do |day|
        { day_of_week: day, opening_time: '09:00', closing_time: '18:00' }
      end
    end

    if params
      filtered_params = params.slice(*ATTRIBUTES)
      super(filtered_params)
    else
      super()
    end
  end

  def save
    return false unless valid?

    shop = Shop.new(
      name: shop_name,
      address: address,
      phone_number: phone_number,
      duel_space_available: duel_space_available,
      opening_hours: opening_hours,
      official_hp: official_hp,
      twitter: twitter,
      instagram: instagram,
      tag_list: tag_list,
      user_id: user_id
    )
    if shop.save
      business_hours_attributes.each do |bh_attr|
        shop.business_hours.create(bh_attr)
      end
      true
    else
      errors.merge!(shop.errors)
      false
    end
  end

  def update(shop)
    return false unless valid?

    shop.assign_attributes(
      name: shop_name,
      address: address,
      phone_number: phone_number,
      duel_space_available: duel_space_available,
      opening_hours: opening_hours,
      official_hp: official_hp,
      twitter: twitter,
      instagram: instagram,
      tag_list: tag_list
    )
    if shop.save
      shop.business_hours.destroy_all
      business_hours_attributes.each do |bh_attr|
        shop.business_hours.create(bh_attr)
      end
      true
    else
      errors.merge!(shop.errors)
      false
    end
  end

  def business_hours
    business_hours_attributes
  end

  private

  def validate_business_hours
    business_hours_attributes.each do |bh|
      errors.add(:base, "Business hours Opening time can't be blank") if bh[:opening_time].blank?
      errors.add(:base, "Business hours Closing time can't be blank") if bh[:closing_time].blank?
    end
  end
end
