package twinspire.utils;

import kha.System;

class Timer
{

	private var _lastTime:Float;
	private var _dt:Float;
	private var _tickValues:Array<Float>;
	private var _tickValueIndex:Int;

	public function new(timers:Int)
	{
		_tickValues = [];
		
		for (i in 0...timers)
			_tickValues.push(0);

		_lastTime = System.time;
	}

	public function begin()
	{
		_tickValueIndex = -1;
		_dt = System.time - _lastTime;
	}

	public function tick(seconds:Float, ?index:Int = -1)
	{
		var index_in = 0;
		if (index > -1)
			index_in = index;
		else
			index_in = ++_tickValueIndex;
		
		_tickValues[index_in] += _dt;
		if (_tickValues[index_in] >= seconds)
		{
			_tickValues[index_in] = 0.0;
			return true;
		}

		return false;
	}

	public function end()
	{
		_tickValueIndex = -1;
		_lastTime = System.time;
	}

}