package uec.keystoneAcc.devices.aes

import chisel3._
import chisel3.util._
import freechips.rocketchip.config._
import freechips.rocketchip.tile._
import freechips.rocketchip.rocket.constants._

class  AESROCC(opcodes: OpcodeSet, val n: Int = 4)(implicit p: Parameters) extends LazyRoCC(opcodes) {
  override lazy val module = new AESROCCModuleImp(this)
}

class AESROCCModuleImp(outer: AESROCC)(implicit p: Parameters) extends LazyRoCCModuleImp(outer)
  with HasCoreParameters
  with MemoryOpConstants
{
  val cmd = Queue(io.cmd)
  val funct = cmd.bits.inst.funct
  val memRespTag = io.mem.resp.bits.tag(log2Up(outer.n)-1,0)

  cmd.ready := true.B
  // The command always is ready here. Is just like an ALU

  // PROC RESPONSE INTERFACE
  io.resp.valid := cmd.valid
  io.resp.bits.rd := cmd.bits.inst.rd
  io.resp.bits.data := sboxGated(cmd.bits.rs1) // rs2 is ignored.. totally
  io.busy := cmd.valid
  // Be busy when have pending memory requests or committed possibility of pending requests
  io.interrupt := Bool(false)
  // Set this true to trigger an interrupt on the processor (please refer to supervisor documentation)

  // MEMORY REQUEST INTERFACE
  io.mem.req.valid := false.B
  io.mem.req.bits.addr := 0.U
  io.mem.req.bits.tag := 0.U
  io.mem.req.bits.cmd := 0.U // perform a load (M_XWR for stores)
  io.mem.req.bits.size := 0.U
  io.mem.req.bits.signed := Bool(false)
  io.mem.req.bits.data := Bits(0) // we're not performing any stores...
  io.mem.req.bits.phys := Bool(false)
}