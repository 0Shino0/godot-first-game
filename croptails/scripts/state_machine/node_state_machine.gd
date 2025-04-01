class_name NodeStateMachine
extends Node

# 导出变量，初始状态节点，允许在编辑器中设置
@export var initial_node_state : NodeState

# 存储状态节点的字典
var node_states : Dictionary = {}
# 当前状态节点
var current_node_state : NodeState
# 当前状态节点的名称
var current_node_state_name : String
#父节点名称
var parent_node_name: String

# 准备函数，在节点准备好时调用
func _ready() -> void:
	parent_node_name = get_parent().name
	# 遍历所有子节点
	for child in get_children():
		# 如果子节点是 NodeState 类型
		if child is NodeState:
			# 将状态节点添加到字典中，键为节点名称的小写形式
			node_states[child.name.to_lower()] = child
			# 连接状态节点的 transition 信号到 transition_to 方法
			child.transition.connect(transition_to)
	
	# 如果设置了初始状态节点
	if initial_node_state:
		# 调用初始状态的进入方法
		initial_node_state._on_enter()
		# 设置当前状态为初始状态
		current_node_state = initial_node_state
		#置当前状态机的名字
		current_node_state_name = current_node_state.name.to_lower()

# 每帧调用的处理函数
func _process(delta : float) -> void:
	# 如果当前状态存在
	if current_node_state:
		# 调用当前状态的处理方法
		current_node_state._on_process(delta)
		# 打印当前状态名称
	print(parent_node_name, " Current State: ", current_node_state_name)

# 每帧物理处理函数
func _physics_process(delta: float) -> void:
	# 如果当前状态存在
	if current_node_state:
		# 调用当前状态的物理处理方法
		current_node_state._on_physics_process(delta)
		# 调用当前状态的下一个转换方法
		current_node_state._on_next_transitions()

# 状态转换函数
func transition_to(node_state_name : String) -> void:
	# 如果要转换的状态与当前状态相同，直接返回
	if node_state_name == current_node_state.name.to_lower():
		return
	
	# 获取新的状态节点
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	# 如果新的状态节点不存在，直接返回
	if !new_node_state:
		return
	
	# 如果当前状态存在，调用其退出方法
	if current_node_state:
		current_node_state._on_exit()
	
	# 调用新状态的进入方法
	new_node_state._on_enter()
	
	# 更新当前状态为新状态
	current_node_state = new_node_state
	# 更新当前状态名称
	current_node_state_name = current_node_state.name.to_lower()
	# 打印当前状态名称
	#print("Current State: ", current_node_state_name)
