shader_type canvas_item;

//摇动强度
uniform float shake_intensity = 1.0;
//摇动速度
uniform float shake_speed = 20.0;

// 顶点函数
void vertex() {
	//从顶部始操纵每个像素的顶点，然后去底部产生共享效果
	//创建一个向量
	vec2 shake = vec2(0.0);
	
	//如果顶点 点y 小于0.0
	if (VERTEX.y < 0.0) {
		//因为Sprite2D 位于x轴上方，并且我们沿着y轴向上时，Godot中y轴的值为负值
		shake.x = sin(TIME * shake_speed + VERTEX.y) * shake_intensity;
	}
	
	//将shake属性应用到顶点
	VERTEX.xy += shake;
}

// 片段函数
void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
