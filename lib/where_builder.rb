#encoding : utf-8
require "where_builder/version"

module WhereBuilder

=begin
  use this tool can build a where sentence for sql, it's can ignore a condition when it's para is nil or black string.
  my purpose is not check nil for every condition, don't repeat so much if else.
=end
  class WhereBuilder

=begin
  add first condition on 'where ..' or '(..)', you can use AND(..) or OR(..), it's ok, just ugly
  cond_str:  like 'a.name=?', 'a.id=b.user_id'
  para:   like 'leo', 123, nil
  
  return : fn
=end
    def add(cond_str, para=nil)
      if (para == nil or para.to_s.strip.size == 0) and cond_str.include?('?') 
        return
      end
      #TODO in and not in
      return lambda{return cond_str, para}
    end

=begin
  add a 'and' condition on 'where ..' or '(..)', 
  cond_str:  like 'a.name=?', 'a.id=b.user_id' or nil, if it's nil, just append a ' AND ' str, 
  para:   like 'leo', 123, nil

  return : fn
=end
    def AND(cond_str=nil, para=nil)
      if cond_str == nil 
        return lambda{return " AND", nil}
      end
      if (para == nil or para.to_s.strip.size == 0) and cond_str.include?('?') 
        return
      end
      return lambda{return " AND #{cond_str}", para}
    end

=begin
  add a 'or' condition on 'where ..' or '(..)', 
  cond_str:  like 'a.name=?', 'a.id=b.user_id' or nil, if it's nil, just append a ' OR ' str, 
  para:   like 'leo', 123, nil
  
  return : fn
=end
    def OR(cond_str=nil, para=nil)
      if cond_str == nil 
        return lambda{return " OR", nil}
      end
      if (para == nil or para.to_s.strip.size == 0) and cond_str.include?('?') 
        return
      end
      return lambda{return " OR #{cond_str}", para}
    end

=begin
  if you want add some condition with '()', use this method.
  use like this : 
  f = WhereBuilder.new()
  f.bracket(f.add(...), f.AND(...), f.AND(...))
  
  return : fn
=end
    def bracket(*args)
      fn = _build_fn(*args)
      return if fn == nil
      para = fn.call
      if para == nil || para.size == 0
        return
      end
      return lambda{return " (#{para[0]})", para[1]}
    end

=begin
  do not use this method if you do't want to fix bug or upgrade this tool.
=end
    def _build_fn(*args)
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

=begin
  this is the enter for this tool, 
  use it like this : 
  f = WhereBuilder.new()

  string, para_list = f.build(
                          f.add(...), 
                          f.AND(...), 
                          f.AND(...), 
                          f.bracket(
                            f.add(...), 
                            f.OR(...))
                          f.OR(...))
  
  return : [string, para_list]
=end
    def build(*args)
      fn = _build_fn(*args)
      if fn == nil
        return ''
      end
      v = fn.call()
      return ["WHERE#{v[0]}", v[1]]
    end

  end # class WhereBuilder
end
