module Learnery
  module ViewPathHelper
    # to get the views in the same order as in regular app using this engine
    def prepend_dummy_path
      dummy_paths = view_paths.select{|p| p.to_s =~/test\/dummy/ }
      prepend_view_path( dummy_paths )
      # raise view_paths.map(&:to_s).join(",")
    end
  end
end
