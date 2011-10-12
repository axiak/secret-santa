generate_mappings = (flattened_data) ->
  result = {}
  shuffled = _.shuffle(flattened_data)
  _.each flattened_data, (name, idx) ->
    result[name] = shuffled[idx]
  result

valid = (mappings, data) ->
  name_groups = {}
  _.each data, (item, idx) ->
    _.each item, (name) ->
      name_groups[name] = idx

  this_is_valid = true

  _.each mappings, (from, to) ->
    if mappings[from] == to or name_groups[from] == name_groups[to]
      this_is_valid = false
      return false
  this_is_valid

check_maps = (all_mappings, current_mappings) ->
  is_valid = true
  _.each current_mappings, (from, to) ->
    _.each all_mappings, (mapping) ->
      if mapping[from] == to or mapping[to] == from
        is_valid = false
  is_valid

$(() ->
  data = [
    ['Yalu', 'Mike']
    ['Maureen', 'Scott']
    ['Peter', 'Tracy']
    ['Joseph']
  ]
  window.d = data
  $("#generate").click(() ->
    fdata = _.flatten(data)
    all_mappings = []
    for i in [1..1]
      mappings = generate_mappings(fdata)
      while not valid(mappings, data) or not check_maps(all_mappings, mappings)
        mappings = generate_mappings(fdata)
      all_mappings.push(mappings)

    result = $("#result")
    result.html("")
    result.append("<table><tr><th>Santa</th><th>Recipient</th></tr><tbody></tbody></table>")
    body = $("tbody:first", result)
    from_list = _.keys(all_mappings[0])
    from_list.sort()

    _.each from_list, (from) ->
      _.each all_mappings, (mapping) ->
        to = mapping[from]
        body.append("<tr><td>" + from + "</td><td>" + to + "</td></tr>")

    $("#generate").hide()

  )
)
