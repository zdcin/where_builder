#encoding : utf-8
require "where_builder/version"

module WhereBuilder
  class WhereBuilder

    def add(cond_str, para)
      if para == nil || para.to_s.strip.size == 0
        return
      end
      #TODO in and not in
      return lambda{return cond_str, para}
    end

    def AND(cond_str=nil, para=nil)
      if cond_str == nil 
        return lambda{return " AND", nil}
      end
      if para == nil || para.to_s.strip.size == 0
        return
      end
      return lambda{return " AND #{cond_str}", para}
    end

    def OR(cond_str=nil, para=nil)
      if cond_str == nil 
        return lambda{return " OR", nil}
      end
      if para == nil || para.to_s.strip.size == 0
        return
      end
      return lambda{return " OR #{cond_str}", para}
    end

    def bracket(*args2)
      fn = build_fn(*args2)
      return if fn == nil
      para = fn.call
      if para == nil || para.size == 0
        return
      end
      return lambda{return " (#{para[0]})", para[1]}
    end

    def build_fn(*args)
      cond_str = []
      para_list = []
      size = args.size
      index = 0
      while index < size
        fn = args[index]
        if fn == nil
          index += 1
          next
        end
        typle = fn.call()
        if typle == nil
          index += 1
          next
        end
        cond_str << typle[0]
        
        if typle[1].class == Array
          _index = 0
          while _index < typle[1].size
            para_list << typle[1][_index]
            _index += 1
          end
        elsif typle[1] != nil
          para_list << typle[1]
        end

        index += 1
      end #while index < size
      if cond_str.size == 0 
        return 
      end
      if cond_str[0].strip.start_with? 'AND ' or cond_str[0].strip.start_with? 'OR '
        cond1 = cond_str[0].strip
        cond1 = " #{cond1[3..-1]}"
        cond_str[0] = cond1
      end
      return lambda{return " #{cond_str.join('')}", para_list}
    end

    def build(*args)
      fn = build_fn(*args)
      if fn == nil
        return ''
      end
      v = fn.call()
      return ["WHERE#{v[0]}", v[1]]
    end

  end # class WhereBuilder
end
