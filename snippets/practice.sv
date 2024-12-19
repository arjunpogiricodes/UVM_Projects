

///////////   vcs -sverilog -ntb_opts uvm -full64 filename.sv
			//	./simv

/*

./simv -a vcs.log -cm_dir ./mem_cov1 
	urg -dir mem_cov1.vdb -format both -report urgReport1

verdi -cov -covdir mem_cov1.vdb

*/

import uvm_pkg::*;

class wr_agent_config extends uvm_object;

	`uvm_object_utils(wr_agent_config)

uvm_active_passive_enum is_active = UVM_ACTIVE;

function new(string name="wr_agent_config");
	super.new(name);
endfunction

endclass


class rd_agent_config extends uvm_object;

	`uvm_object_utils(rd_agent_config)

uvm_active_passive_enum is_active = UVM_ACTIVE;

function new(string name="rd_agent_config");
	super.new(name);
endfunction

endclass


class env_config extends uvm_object;

	`uvm_object_utils(env_config);

	wr_agent_config wr_cfg;
	rd_agent_config rd_cfg;

bit	has_wr_agent = 1;
bit 	has_rd_agent = 1;


function new(string name="env_config");
	super.new(name);
endfunction

endclass


////////////////////////////////////////////////////////WRITE
class write_xtn extends uvm_sequence_item;
	`uvm_object_utils(write_xtn)

function new(string name="write_xtn");
	super.new(name);
endfunction

endclass


class wr_sequencer extends uvm_sequencer #(write_xtn);

	`uvm_component_utils(wr_sequencer)

	function new(string name="wr_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass


class wr_driver extends uvm_driver#(write_xtn);

	`uvm_component_utils(wr_driver)

	function new(string name="wr_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass

class wr_monitor extends uvm_monitor;

	`uvm_component_utils(wr_monitor)

	function new(string name="wr_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass

class wr_agent extends uvm_agent;
	
	`uvm_component_utils(wr_agent)

	wr_sequencer wr_seqr;
	wr_driver wr_drv;
	wr_monitor wr_mon;

	wr_agent_config m_cfg;

 	function new(string name="wr_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		
	uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",m_cfg);
		
	wr_mon = wr_monitor::type_id::create("wr_mon",this);
	if(m_cfg.is_active == UVM_ACTIVE)
	begin
	wr_seqr = wr_sequencer::type_id::create("wr_seqr",this);
	wr_drv = wr_driver::type_id::create("wr_drv",this);
	end

	endfunction

endclass

class wr_agent_top extends uvm_env;

	`uvm_component_utils(wr_agent_top)

	env_config m_cfg;
	wr_agent agent;

	function new(string name="wr_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		
	uvm_config_db #(env_config)::get(this,"","env_config",m_cfg);

	if(m_cfg.has_wr_agent)
		agent = wr_agent::type_id::create("agent",this);
	
	endfunction

endclass
		
/////////////////////////////////////////////////////////////////////READ

class read_xtn extends uvm_sequence_item;
	`uvm_object_utils(read_xtn)

function new(string name="read_xtn");
	super.new(name);
endfunction

endclass


class rd_sequencer extends uvm_sequencer #(read_xtn);

	`uvm_component_utils(rd_sequencer)

	function new(string name="rd_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass


class rd_driver extends uvm_driver#(read_xtn);

	`uvm_component_utils(rd_driver)

	function new(string name="rd_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass

class rd_monitor extends uvm_monitor;

	`uvm_component_utils(rd_monitor)

	function new(string name="rd_monitor",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass

class rd_agent extends uvm_agent;
	
	`uvm_component_utils(rd_agent)

	rd_sequencer rd_seqr;
	rd_driver rd_drv;
	rd_monitor rd_mon;

	rd_agent_config m_cfg;

 	function new(string name="rd_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		
	uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",m_cfg);
		
	rd_mon = rd_monitor::type_id::create("rd_mon",this);
	if(m_cfg.is_active == UVM_ACTIVE)
	begin
	rd_seqr = rd_sequencer::type_id::create("rd_seqr",this);
	rd_drv = rd_driver::type_id::create("rd_drv",this);
	end

	endfunction

endclass

class rd_agent_top extends uvm_env;

	`uvm_component_utils(rd_agent_top)

	env_config m_cfg;
	rd_agent agent;

	function new(string name="rd_agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
	
	uvm_config_db #(env_config)::get(this,"","env_config",m_cfg);

	if(m_cfg.has_rd_agent)
	agent = rd_agent::type_id::create("agent",this);
	
	endfunction

endclass

/////////////////////////////////////////////////////////////////////////////////TB

class env extends uvm_env;

	`uvm_component_utils(env)
	
	wr_agent_top wr_top;
	rd_agent_top rd_top;

	env_config m_cfg;

	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);

	uvm_config_db #(env_config)::get(this,"","env_config",m_cfg);
		
	if(m_cfg.has_wr_agent)
		wr_top = wr_agent_top::type_id::create("wr_top",this);
	if(m_cfg.has_rd_agent)
		rd_top = rd_agent_top::type_id::create("rd_agent",this);

	endfunction

endclass


////////////////////////////////////////////////////////////////////////////////TEST

class test extends uvm_test;
	
	`uvm_component_utils(test)

	env env_h;
	
	env_config m_cfg;
	wr_agent_config wr_cfg;
	rd_agent_config rd_cfg;

	bit has_wr_agent = 1;
     	bit has_rd_agent = 1;

		function new(string name="test",uvm_component parent);
		super.new(name,parent);
		endfunction

	function void build_phase(uvm_phase phase);
	
	env_h = env::type_id::create("env_h",this);
	
	m_cfg = env_config::type_id::create("m_cfg");

	if(has_wr_agent)
	begin
		wr_cfg = wr_agent_config::type_id::create("wr_cfg");
		wr_cfg.is_active = UVM_ACTIVE;
		m_cfg.wr_cfg = wr_cfg;
		uvm_config_db #(wr_agent_config)::set(this,"*","wr_agent_config",wr_cfg);
	end

	if(has_rd_agent)
	begin
		rd_cfg = rd_agent_config::type_id::create("rd_cfg");
		rd_cfg.is_active = UVM_PASSIVE;
		m_cfg.rd_cfg = rd_cfg;
		uvm_config_db #(rd_agent_config)::set(this,"*","rd_agent_config",rd_cfg);
	end

	m_cfg.has_wr_agent = has_wr_agent;
	m_cfg.has_rd_agent = has_rd_agent;

	uvm_config_db #(env_config)::set(this,"*","env_config",m_cfg);

	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
endclass


////////////////////////////////////////////////////////////////////////TOP

module top();

`include "uvm_macros.svh";

import uvm_pkg::*;

initial begin

run_test("test");

	end

endmodule


