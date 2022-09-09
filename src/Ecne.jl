# ecne command-line tool
# TODO: add support for trusted R1CS files

using Dates
using ArgParse

import R1CSConstraintSolver: solveWithTrustedFunctions

function main(args)

    s = ArgParseSettings(description="Ecne command-line helper")

    @add_arg_table! s begin
        "--r1cs"
        help = "de-optimized R1CS file to verify"
        required = true
        "--name"
        help = "Circuit name"
        required = true
        "--sym"
        help = "symbol file with labels"
        required = true
        "--trusted"
        help = "Optional trusted R1CS file"
        "--compatible"
        help = "Ignore additional sections in r1cs (compatible with circom>=2.0.6). Note that this may create runtime/soundness issues if custom gates are required."
        action = :store_true
        "--silent"
        help = "Do not print all the variable information when solving is done. Show the final conclusion directly."
        action = :store_true
    end

    parsed_args = parse_args(args, s)

    #dict = Dict("result" => "empty", "constraints" => ["empty"])

    try
        solveWithTrustedFunctions(parsed_args["r1cs"], parsed_args["name"], input_sym=parsed_args["sym"], debug=false, compatible=parsed_args["compatible"], silent=parsed_args["silent"])
    catch e
        println("Error while running solveWithTrustedFunctions\n", e)
    end
end

main(ARGS)

