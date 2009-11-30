module TextFieldsStripperExtension
    module TextFieldsStripper #:nodoc:
      
      def self.append_features(base)
        super
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def strip_text_fields(*fields_to_strip)  
          if fields_to_strip.size > 0
            fields = fields_to_strip      
          end
          before_validation do  |record|  
            if fields.nil? 
                fields = record.attributes.keys            
            end
            for field in fields do     
              value = record[field]
              if !value.nil? && value.respond_to?(:strip) 
                s = value.strip
                s.size == 0 ? record[field] = nil : record[field] = s
              end
            end                      
          end
        end
        
      end
  end
end


