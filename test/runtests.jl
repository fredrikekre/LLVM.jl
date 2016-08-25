using LLVM
using Base.Test

# support
let
    @test LLVM.BoolFromLLVM(LLVMTrue) == true
    @test LLVM.BoolFromLLVM(LLVMFalse) == false

    @test_throws ArgumentError LLVM.BoolFromLLVM(LLVM.API.LLVMBool(2))

    @test LLVM.BoolToLLVM(true) == LLVMTrue
    @test LLVM.BoolToLLVM(false) == LLVMFalse
end


# pass registry
passreg = GlobalPassRegistry()

InitializeCore(passreg)
include("core.jl")
include("irbuilder.jl")

InitializeTransformUtils(passreg)

InitializeScalarOpts(passreg)

InitializeObjCARCOpts(passreg)

InitializeVectorization(passreg)

InitializeInstCombine(passreg)

InitializeIPO(passreg)

InitializeInstrumentation(passreg)

InitializeAnalysis(passreg)

InitializeIPA(passreg)

InitializeCodeGen(passreg)

InitializeTarget(passreg)


Shutdown()
