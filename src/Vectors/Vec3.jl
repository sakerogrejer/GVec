# Real Valued 3D Vector Type
mutable struct Vec3{T} <: AbstractVector{T}
    x::T
    y::T
    z::T
end

# Constructors
Vec3(x::T) where T = Vec3{T}(x, x, x)  # Uniform 3D vector

# Base functions
Base.getindex(v::Vec3, i::Int) = i == 1 ? v.x : i == 2 ? v.y : v.z # Get element at index i
Base.setindex!(v::Vec3, val, i::Int) = i == 1 ? (v.x = val) : i == 2 ? (v.y = val) : (v.z = val) # Set element at index i

# Vector operations
dot(v1::Vec3, v2::Vec3) = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z # Dot product
norm(v::Vec3) = sqrt(v.x^2 + v.y^2 + v.z^2) # Norm
normalize(v::Vec3) = v / norm(v) # Normalize
cross(v1::Vec3, v2::Vec3) = Vec3(
    v1.y * v2.z - v1.z * v2.y,
    v1.z * v2.x - v1.x * v2.z,
    v1.x * v2.y - v1.y * v2.x
) # Cross product

# Arithmetic operations
Base.:+(v1::Vec3, v2::Vec3) = Vec3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z) # Addition
Base.:-(v1::Vec3, v2::Vec3) = Vec3(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)  # Subtraction
Base.:*(a::T, v::Vec3) where T <: Number = Vec3(a * v.x, a * v.y, a * v.z) # Scalar multiplication
Base.:*(v::Vec3, a::T) where T <: Number = Vec3(a * v.x, a * v.y, a * v.z) # Scalar multiplication
Base.:/(v::Vec3, a::T) where T <: Number = Vec3(v.x / a, v.y / a, v.z / a) # Scalar division

# Comparison operations
Base.:(==)(v1::Vec3, v2::Vec3) = v1.x == v2.x && v1.y == v2.y && v1.z == v2.z # Equality
Base.:(!=)(v1::Vec3, v2::Vec3) = !(v1 == v2) # Inequality

# Print
Base.show(io::IO, v::Vec3) = print(io, "Vec3{", eltype(v), "}(", v.x, ", ", v.y, ", ", v.z, ")")
Base.show(io::IO, ::MIME"text/plain", v::Vec3) = show(io, v)
Base.show(io::IO, ::MIME"text/html", v::Vec3) = show(io, v)