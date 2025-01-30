extends GUIDETestBase

# Test for https://github.com/godotneers/G.U.I.D.E/issues/13
func test_node_leak():
	var context = mapping_context()
	var action = action()
	var input = input_key(KEY_Q)
	
	map(context, action, input)
	
	GUIDE.enable_mapping_context(context)

	# test formatting something	
	var formatter = GUIDEInputFormatter.for_active_contexts()
	var text = await formatter.action_as_richtext_async(action)
	assert_string_contains(text, "[img")
	
	# WHEN: i run the cdleanup
	GUIDEInputFormatter.cleanup()
	# give the thing one frame to let the cleanup kick in
	await get_tree().process_frame
	
	# THEN: the cleanup works
	assert_no_new_orphans()
	

	
