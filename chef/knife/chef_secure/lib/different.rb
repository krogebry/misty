##
# Different function ripped from https://gist.github.com/2631752
#
# @author Bryan Kroger ( bryan.kroger@hp.com )
# @copyright 2012 HPCS

def different?(a, b, bi_directional=true)
  return [a.class.name, nil] if !a.nil? && b.nil?
  return [nil, b.class.name] if !b.nil? && a.nil?
  
  differences = {}
  a.each do |k, v|
    if !v.nil? && b[k].nil?
      differences[k] = [v, nil]
      next
    elsif !b[k].nil? && v.nil?
      differences[k] = [nil, b[k]]
      next
    end
      
    if v.is_a?(Hash)
      unless b[k].is_a?(Hash)
        differences[k] = "Different types" 
        next
      end
      diff = different?(a[k], b[k])
      differences[k] = diff if !diff.nil? && diff.count > 0
    
    elsif v.is_a?(Array)
      unless b[k].is_a?(Array)
        differences[k] = "Different types"
        next
      end
      
      c = 0
      diff = v.map do |n|
        if n.is_a?(Hash)
          diffs = different?(n, b[k][c])
          c += 1
          ["Differences: ", diffs] unless diffs.nil?
        else
          c += 1
          [n , b[c]] unless b[c] == n
        end
      end.compact
      
      differences[k] = diff if diff.count > 0
      
    else
      differences[k] = [v, b[k]] unless v == b[k]
      
    end
  end
  
  return differences if !differences.nil? && differences.count > 0
end
